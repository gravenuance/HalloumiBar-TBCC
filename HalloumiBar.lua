local addonName, addonTable = ...

local is_debugging = false

local specs_by_guid_list = {}

-- Number of buttons to spawn per bar
local total_icons_per_bar = 8
-- Button bars
local number_of_bars = 3
local bars = {}

-- Delay for more accurate tracking
local count_delay_from_start = 0

-- Size of side of square
local square_size = 30
local font_size = floor(square_size / 2)

-- How often on_update runs
local update_interval = 0.1
local total_time_elapsed = 0

--Player identifier
local player_guid = UnitGUID("player")
local player_class = select(2, UnitClass("player"))

--Bar locations
local bar_locations = {
    [1] = { -225, -150 },
    [2] = { -225, -200 },
    [3] = { -225, -250 }
}

local is_disabled = false

local active_spells = {}

-- i made it look so weird but it just updates text
local function hb_update_text(bar_index, button_index, cooldown)
    bars[bar_index][button_index].text:SetFont(STANDARD_TEXT_FONT,font_size,"OUTLINE")
    if (cooldown >= 10) then
        bars[bar_index][button_index].text:SetTextColor(1,1,0,1)
        if(cooldown > 60) then
            bars[bar_index][button_index].text:SetText(string.format("%.0fm", floor(cooldown/60)))
            return
        end
        bars[bar_index][button_index].text:SetText(string.format(" %.0f", floor(cooldown)))
    else
        bars[bar_index][button_index].text:SetTextColor(1,0,0,1)
        bars[bar_index][button_index].text:SetText(string.format("  %.0f", floor(cooldown)))
    end
end

local function hb_get_duration(value)
    if value.duration ~= nil then
        return value.duration -- if only one duration present, use this
    end
    if specs_by_guid_list[value.src_guid] ~= nil then -- will see if guid has spec (found thru identifying spells)
        if value.durations[specs_by_guid_list[value.src_guid]] ~= nil then
            return value.durations[specs_by_guid_list[value.src_guid]] -- and get the correct duration
        end
    end
    for key, value in pairs(value.durations) do -- will get the first duration, not always at index 0
        return value
    end
end

local function hb_remove(id, src_guid, dst_guid)
    local key = id .. "_" .. src_guid .. "_" .. dst_guid
    if active_spells[key] and active_spells[key].button_index then
        local index = active_spells[key].button_index
        local jndex = active_spells[key].bar_index[1]
        while index < bars[jndex].length - 1 do
            bars[jndex][index].key = bars[jndex][index+1].key
            local next_value = active_spells[bars[jndex][index].key]
            if next_value then
                bars[jndex][index].cd:SetCooldown(next_value.start,hb_get_duration(next_value))
                active_spells[bars[jndex][index].key].button_index = index
            end
            bars[jndex][index].texture:SetTexture(bars[jndex][index+1].texture:GetTexture())
            bars[jndex][index].text:SetText(bars[jndex][index+1].text:GetText())
            index = index + 1
        end
        bars[jndex][index]:Hide()
        bars[jndex][index].cd:SetCooldown(0,0)
        bars[jndex][index].text:SetText("")
        bars[jndex][index].key = nil 
        bars[jndex].length = bars[jndex].length - 1
    end
    active_spells[key] = nil
end

local function hb_add_icon(key, value, duration)
    local bar_index = value.bar_index[1]
    if bars[bar_index].length <= total_icons_per_bar then
        local index = bars[bar_index].length
        bars[bar_index][index].key = key
        local icon = select(3, GetSpellInfo(value.id))
        bars[bar_index][index].texture:SetTexture(icon)
        bars[bar_index][index].cd:SetCooldown(value.start, duration)
        bars[bar_index][index]:Show()
        bars[bar_index].length = bars[bar_index].length + 1
        hb_update_text(bar_index, index, value.cooldown)
        active_spells[key].button_index = index
    end
end

local function hb_update_cooldowns()
    for key, value in pairs(active_spells) do
        local get_time = GetTime()
        local duration = hb_get_duration(value)
        active_spells[key].cooldown = value.start + duration - get_time
        if(active_spells[key].cooldown <= 0) then
            if value.has_charges and value.has_charges < value.max_charges then -- this is a retail thing
                active_spells[key].has_charges = value.has_charges + 1
                active_spells[key].start = get_time
                active_spells[key].cooldown = duration
                if value.button_index then
                    bars[value.bar_index][value.button_index].cd:SetCooldown(get_time, duration)
                    hb_update_text(value.bar_index, value.button_index, duration)
                end
            else
                hb_remove(value.id, value.src_guid, value.dst_guid)
            end
        elseif value.button_index then
            hb_update_text(value.bar_index[1], value.button_index, active_spells[key].cooldown)
        else
            hb_add_icon(key, active_spells[key], duration)
        end
    end
end

local function hb_on_update(self, elapsed)
    total_time_elapsed = total_time_elapsed + elapsed;
    if total_time_elapsed >= update_interval then
        --print(#active_spells)
        --if #active_spells == 1 then
        --    hb_frame:SetScript("OnUpdate", nil)
        --    return
        --end
        --doesn't work but who cares
        hb_update_cooldowns()
        total_time_elapsed = 0
    end

end

local function hb_remove_all_from_src(id, src_guid, cooldown)
    for key, value in pairs(active_spells) do
        if value.id == id and value.src_guid == src_guid then
            if cooldown and value.cooldown >= cooldown then
                return false
            end
            if value.dst_guid ~= "DEV_GUID" then
                hb_remove(id, src_guid, value.dst_guid)
            end
        end
    end
end

local function hb_add(bar_index, list, id, src_guid, dst_guid, related_spell)
    local key = id .. "_".. src_guid .. "_".. dst_guid
    local duration = hb_get_duration(list[id])
    local get_time = GetTime()
    local cooldown = get_time-count_delay_from_start + duration
    if (related_spell ~= nil and related_spell.is_not_unique == (false or nil)) or (list[id] ~= nil and list[id].is_not_unique == (false or nil)) then
        hb_remove_all_from_src(id, src_guid, cooldown)
    end
    active_spells[key] = {}
    active_spells[key].id = id
    active_spells[key].src_guid = src_guid
    active_spells[key].dst_guid = dst_guid
    active_spells[key].bar_index = bar_index
    if related_spell ~= nil then
        active_spells[key].duration = duration
        active_spells[key].event_type = "DEV_TYPE"
    else
        active_spells[key].event_type = list[id].event_type
        if list[id].has_charges ~= nil then
            active_spells[key].has_charges = list[id].has_charges - 1
            active_spells[key].max_charges = list[id].has_charges
        end
        active_spells[key].durations = list[id].durations
    end
    active_spells[key].start = get_time*2-count_delay_from_start
    active_spells[key].cooldown = cooldown
    if related_spell == nil and list[id].spells_that_also_go_on_cooldown then
        for key, value in pairs(list[id].spells_that_also_go_on_cooldown) do
            if value.id ~= id then
                hb_add({bar_index[2], bar_index[2]}, list, value.id, src_guid, "DEV_GUID", value)
            end
        end
    end
    hb_frame:SetScript("OnUpdate", hb_on_update)
end

local function hb_handle_event(bar_index, combat_event, id, src_guid, dst_guid)
    if addonTable.spells_list[id].event_type == "aura" then
        if combat_event == "SPELL_AURA_APPLIED" then
            hb_add(bar_index, addonTable.spells_list, id, src_guid, dst_guid)
            return
        elseif combat_event == "SPELL_AURA_REMOVED" then
            hb_remove(id, src_guid, dst_guid)
            return
        elseif combat_event == "SPELL_AURA_REFRESH" then
            hb_add(bar_index, addonTable.spells_list, id, src_guid, dst_guid)
            return
        end
    else
        if (combat_event == "SPELL_DAMAGE" or combat_event == "SPELL_MISSED") and addonTable.spells_list[id].event_type == "spell_damage"  then
            hb_add(bar_index, addonTable.spells_list, id, src_guid, dst_guid)
            return
        elseif combat_event == "SPELL_CAST_SUCCESS" and addonTable.spells_list[id].event_type == "cast_success" then
            hb_add(bar_index, addonTable.spells_list, id, src_guid, dst_guid)
            return
        elseif combat_event == "SPELL_AURA_REMOVED" and addonTable.spells_list[id].event_type == "cooldown_on_remove"  then
            hb_add(bar_index, addonTable.spells_list, id, src_guid, dst_guid)
            return    
        end
    end
end

local function hb_is_in_party(guid)
    if (not IsInRaid() and not IsInGroup()) then
        return false
    end
    for index=1, GetNumGroupMembers() do
        local party_member_guid = nil
        if(IsInRaid()) then
            party_member_guid = UnitGUID("raid" .. index)
        else
            party_member_guid = UnitGUID("party" .. index)
        end
        if (party_member_guid == guid) then
            return true
        end
    end
    return false
end

local function hb_which_bar(list, spell_id, combat_event, src_flags, src_guid, dst_flags, dst_guid)
    if bit.band(src_flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then -- i casted
        if bit.band(list[spell_id].trigger_groups, 1) > 0 then -- triggers when i cast
            if addonTable.spells_list[spell_id].event_type == "aura" then
                if hb_is_in_party(dst_guid) then -- destination is in grp
                    return { 2, 3 } -- friendly (dst) and self bar (src)
                elseif bit.band(dst_flags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then
                    return { 1, 3 } -- enemy (dst) and self bar (src)
                end
            end
            return { 3, 3 } -- self (dst) and self (src)
        end
    elseif hb_is_in_party(src_guid) then -- source is in grp
        if bit.band(list[spell_id].trigger_groups, 2) > 0 then -- triggers when grp casts
            if addonTable.spells_list[spell_id].event_type == "aura" then
                if bit.band(dst_flags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then -- if destination is enemy
                    return { 1, 2 } -- enemy (dst) and friendly (src)
                elseif bit.band(dst_flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then -- if destination is me
                    return { 3, 2 } -- self (dst) and friendly (src)
                end
            end
            return { 2, 2 } -- friendly (dst) and friendly (src)
        end
    elseif bit.band(src_flags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then -- if source is hostile
        if bit.band(src_flags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then -- if source is a player
            if bit.band(list[spell_id].trigger_groups, 4) > 0 then -- triggers when enemy casts
                if addonTable.spells_list[spell_id].event_type == "aura" then
                    if hb_is_in_party(dst_guid) then -- if dest is in grp
                        return { 2, 1 } -- friendly (dst) and enemy (src)
                    elseif bit.band(dst_flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then -- if dest is me
                        return { 3, 1 } -- self (dst) and enemy (src)
                    end
                end
                return { 1, 1 } -- enemy (dst) and enemy (src)
            end
        end
    end
    return nil
end

local function hb_handle_swing_events(spell_type, src_flags, src_guid, dst_flags, dst_guid)
    for id in pairs(addonTable.swing_spells) do
        if (addonTable.swing_spells[id].class == nil or addonTable.swing_spells[id].class == select(2, GetPlayerInfoByGUID(src_guid))) then
            for swing_type in pairs(addonTable.swing_spells[id].swing_types) do
                if swing_type == spell_type then
                    local bar_index = hb_which_bar(addonTable.swing_spells, id, nil, src_flags, src_guid, dst_flags, dst_guid)
                    hb_add(bar_index, addonTable.swing_spells, id, src_guid, dst_guid)
                    return
                end
            end 
        end
    end
end

local function hb_combat_log(...)
    local _, combat_event, _, src_guid, _, src_flags, _, dst_guid, _, dst_flags, _ = ...
    local spell_id, spell_name = select(12, ...)
    count_delay_from_start = GetTime()
    if is_debugging and ((src_guid == player_guid or src_guid == UnitGUID("target"))) then
        print(spell_id)
        print(spell_name)
        print(combat_event)
    end
    if is_disabled then
        return
    end
    if addonTable.spells_list[spell_id] ~= nil and addonTable.spells_list[spell_id].is_special_spell then
        specs_by_guid_list[src_guid] = addonTable.special_spells_list[spell_id]
    end
    if addonTable.spells_list[spell_id] ~= nil then
        local bar_index = hb_which_bar(addonTable.spells_list, spell_id, combat_event, src_flags, src_guid, dst_flags, dst_guid)
        if bar_index == nil then
            return
        end
        if addonTable.spells_list[spell_id].spells_that_are_removed_from_cooldown ~= nil then
            for key, value in pairs(addonTable.spells_list[spell_id].spells_that_are_removed_from_cooldown) do
                hb_remove_all_from_src(value, src_guid)
            end
        end
        hb_handle_event(bar_index, combat_event, spell_id, src_guid, dst_guid)
    elseif combat_event == "SWING_MISSED" then
        hb_handle_swing_events(spell_id, src_flags, src_guid, dst_flags, dst_guid)
    end
end

local function hb_initialize_bars()
    local jndex = 1
    while jndex <= number_of_bars do
        bar = CreateFrame("Frame",nil,UIParent)
        bar:SetWidth(square_size*4)
        bar:SetHeight(square_size)
        bar:SetClampedToScreen(true)
        bar:SetPoint("CENTER", UIParent, "CENTER", bar_locations[jndex][1], bar_locations[jndex][2])
        bar.length = 1
        local location
        local icon
        local cooldown
        local texture
        local text
        local index = 1
        while index <= total_icons_per_bar do
            
            location = square_size * index + 5 * index

            icon = CreateFrame("Frame",nil,bar)
            icon:SetWidth(square_size)
            icon:SetHeight(square_size)
            icon:SetPoint("CENTER",bar,"CENTER",location,0)
            icon:SetFrameStrata("LOW")
            
            texture = icon:CreateTexture(nil,"BACKGROUND")
            texture:SetAllPoints()
            texture:SetTexCoord(0.07,0.9,0.07,0.90) 


            cooldown = CreateFrame("Cooldown",nil, icon, "CooldownFrameTemplate")
            cooldown:SetAllPoints()
            cooldown:SetFrameStrata("MEDIUM")
            
            -- 
            local hidden_text = cooldown:GetRegions()
            hidden_text:SetAlpha(0)
        
            text = cooldown:CreateFontString(nil,"ARTWORK")
            text:SetFont(STANDARD_TEXT_FONT,20,"OUTLINE")
            text:SetTextColor(1,1,0,1)
            text:SetPoint("LEFT",icon,"LEFT",2,0)
            --

            icon.texture = texture
            icon.cd = cooldown
            icon.text = text

            icon:Hide()
            icon.index = index
            bar[index] = icon 
            index = index + 1
        end
        table.insert(bars, 1, bar)
        jndex = jndex + 1
    end   
end

local function hb_clear_spec_list()
    specs_by_guid_list = table.wipe(specs_by_guid_list)
end

local function hb_entering_world()
    for key, value in pairs(active_spells) do
        hb_remove(value.id, value.src_guid, value.dst_guid)
    end
end

local function hb_commands(sub_string)
    if sub_string == "debug" then
        is_debugging = not is_debugging
        if is_debugging then
            print("Debugging |cFFFFB6C1on|r.")
        else 
            print("Debugging |cFFFFB6C1off|r.")
        end
    elseif sub_string == "clear" then
        hb_entering_world()
        hb_clear_spec_list()
        print("|cFFFFB6C1HalloumiBar|r cleared.")
    elseif sub_string == "disable" then
        is_disabled = not is_disabled
        if is_disabled then
            print("Disabled |cFFFFB6C1on|r.")
        else 
            print("Disabled |cFFFFB6C1off|r.")
        end
    else
        print("Available commands: |cFFFFB6C1Debug|r, |cFFFFB6C1clear|r, |cFFFFB6C1disable|r.")
    end
end

local function hb_on_load(self)
    print("|cFFFFB6C1HalloumiBar|r loaded. Type |cFFFFB6C1/hb|r for more info.")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    hb_initialize_bars()
    SlashCmdList["HALLOUMIBAR"] = hb_commands
    SLASH_HALLOUMIBAR1 = "/hb"
end

local event_handler = {
    ["PLAYER_LOGIN"] = function(self) hb_on_load(self) end,
    ["PLAYER_ENTERING_WORLD"] = function(self) hb_entering_world(self) end,
    ["COMBAT_LOG_EVENT_UNFILTERED"] = function(self, ...) hb_combat_log(CombatLogGetCurrentEventInfo()) end,
}

local function hb_on_event(self,event, ...)
	event_handler[event](self, event, ...)
end

if not hb_frame then 
    CreateFrame("Frame","hb_frame",UIParent)
end
hb_frame:SetScript("OnEvent",hb_on_event)
hb_frame:RegisterEvent("PLAYER_LOGIN")
