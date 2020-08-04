local addonName, addonTable = ...

local is_debugging = false

local specs_by_guid_list = {}
-- Track all or target/focus
local track_all = true

-- Number of buttons to spawn per bar
local total_icons_per_bar = 15
-- How many active buttons?
local length_of_hostile_bar = 1
local length_of_party_bar = 1
local length_of_player_bar = 1
-- Button bars
local hostile_bar
local party_bar
local player_bar

-- Delay for more accurate tracking
local count_delay_from_start = 0

-- Size of side of square
local square_size = 45

-- How often on_update runs
local update_interval = 0.1
local total_time_elapsed = 0

--Player identifier
local player_guid = UnitGUID("player")
local player_class = select(2, UnitClass("player"))

--Bar locations
local player_bar_x = -225
local player_bar_y = -225
local party_bar_x = -225
local party_bar_y = -275
local hostile_bar_x = -225
local hostile_bar_y = -325

local is_disabled = false

local party_guid = {}

local function zb_remove_icon(bar, length, id, is_aura, src_guid, dst_guid)
    if is_aura then
        local index = 1
        local found = false
        while index < length do
            if bar[index].id == id and src_guid == bar[index].src_guid then
                if dst_guid and dst_guid == bar[index].dst_guid or bar[index].dst_guid == nil then
                    id = index
                    found = true
                    break
                end
            end
            index = index + 1
        end
        if not found then
            return length
        end  
    end  
    length = length - 1
    local index = id
    while index < length do
        bar[index].id = bar[index+1].id
        bar[index].src_guid = bar[index+1].src_guid
        bar[index].dst_guid = bar[index+1].dst_guid
        bar[index].duration = bar[index+1].duration
        bar[index].start = bar[index+1].start
        bar[index].cooldown = bar[index+1].cooldown
        bar[index].texture:SetTexture(bar[index+1].texture:GetTexture())
        bar[index].text:SetText(bar[index+1].text:GetText())
        bar[index].cd:SetCooldown(bar[index].start,bar[index].duration)
        index = index + 1
    end
    bar[length]:Hide()
    bar[length].flasher:Stop()
    bar[length].is_playing = false
    bar[length].text:SetText("") 
    return length
end


local function zb_update_text(bar, index)
    if (bar[index].cooldown > 60) then
        bar[index].text:SetTextColor(1,1,0,1)
        bar[index].text:SetFont(STANDARD_TEXT_FONT,20,"OUTLINE")
        bar[index].text:SetText(string.format("%.0fm", floor(bar[index].cooldown/60)))
    elseif (bar[index].cooldown >= 10) then
        bar[index].text:SetTextColor(1,1,0,1)
        bar[index].text:SetFont(STANDARD_TEXT_FONT,20,"OUTLINE")
        bar[index].text:SetText(string.format(" %.0f", floor(bar[index].cooldown)))
    else
        bar[index].text:SetTextColor(1,0,0,1)
        bar[index].text:SetFont(STANDARD_TEXT_FONT,24,"OUTLINE")
        bar[index].text:SetText(string.format("  %.0f", floor(bar[index].cooldown)))
    end
end

local function zb_get_duration(list, id)
    if list[id].has_other_duration then
        if specs_by_guid_list[src_guid] then
            if (list[id].duration[specs_by_guid_list[src_guid]]) then
                duration = list[id].duration[specs_by_guid_list[src_guid]]
            end
        else
            return list[id].duration[1]
        end
    else
        return list[id].duration
    end
end

local function zb_update_cooldowns(bar, length, list)
    if length > 1 then
        local index = 1
        local get_time = GetTime()
        while index < length do
            bar[index].cooldown = bar[index].start + bar[index].duration - get_time
            if bar[index].cooldown <= 0 then
                if list[bar[index].id].has_charges and bar[index].has_charges < list[bar[index].id].has_charges then
                    bar[index].has_charges = bar[index].has_charges + 1
                    bar[index].start = get_time
                    bar[index].duration = zb_get_duration(list, bar[index].id)
                    bar[index].cooldown = bar[index].duration
                    bar[index].cd:SetCooldown(bar[index].start,bar[index].duration)
                    zb_update_text(bar, index)
                else
                    length = zb_remove_icon(bar, length, index, false)
                    index = index - 1
                end
            else 
                zb_update_text(bar, index)
                if get_time - bar[index].start >= 1.9 and bar[index].is_playing then
                    bar[index].is_playing = false
                    bar[index].flasher:Stop()
                end
            end
            index = index + 1
        end
    end
    return length
end

local function zb_on_update(self, elapsed)
    total_time_elapsed = total_time_elapsed + elapsed;
    if total_time_elapsed >= update_interval then
        if length_of_player_bar == 1 and length_of_hostile_bar == 1 and length_of_party_bar == 1 then
            zb_frame:SetScript("OnUpdate",nil)
            return
        end
        length_of_player_bar = zb_update_cooldowns(player_bar, length_of_player_bar, addonTable.player_spells_list)
        length_of_hostile_bar = zb_update_cooldowns(hostile_bar, length_of_hostile_bar, addonTable.spells_list)
        length_of_party_bar = zb_update_cooldowns(party_bar, length_of_party_bar, addonTable.spells_list)
        total_time_elapsed = 0
    end
end

local function zb_add_icon(bar, length, id, list, src_guid, dst_guid)
    local get_time = GetTime()
    local index = 1
    while index < length do
        if bar[index].id == id and src_guid == bar[index].src_guid then
            if dst_guid and dst_guid == bar[index].dst_guid or bar[index].dst_guid == nil then
                if list[id].has_charges and bar[index].has_charges > 0 then
                    bar[index].has_charges = bar[index].has_charges - 1
                else
                    bar[index].start = get_time*2-count_delay_from_start
                    bar[index].duration = zb_get_duration(list, id)
                    bar[index].cooldown = bar[index].start + bar[index].duration - get_time
                    bar[index].cd:SetCooldown(bar[index].start,bar[index].duration)
                    zb_update_text(bar, index)
                end
                bar[index].flasher:Play()
                bar[index].is_playing = true
                return length
            end
        end
        index = index + 1
    end
    if length < total_icons_per_bar then
        if dst_guid then
            bar[length].dst_guid = dst_guid
        else
            bar[length].dst_guid = nil
        end
        if list[id].has_charges then
            bar[length].has_charges = list[id].has_charges - 1
        end
        bar[length].src_guid = src_guid
        bar[length].duration = zb_get_duration(list, id)

        bar[length].start = get_time*2-count_delay_from_start
        bar[length].cooldown = bar[length].start + bar[length].duration - get_time
        

        bar[length].id = id

        local _,_,icon = GetSpellInfo(id)
        bar[length].texture:SetTexture(icon)
        
        bar[length].cd:SetCooldown(bar[length].start,bar[length].duration)

        bar[length]:Show()
        bar[length].flasher:Play()
        bar[length].is_playing = true
        zb_update_text(bar, length)
        
        
        zb_frame:SetScript("OnUpdate", zb_on_update)
        return length + 1
    end
    return length
end

local function zb_event_type(combat_event, bar, length, id, line, src_guid, dst_guid)
    if line[id].is_aura then
        if combat_event == "SPELL_AURA_APPLIED" then
            return zb_add_icon(bar, length, id, line, src_guid, dst_guid)
        elseif combat_event == "SPELL_AURA_REMOVED" then
            return zb_remove_icon(bar, length, id, true, src_guid, dst_guid)
        elseif combat_event == "SPELL_AURA_REFRESH" then
            return zb_add_icon(bar, length, id, line, src_guid, dst_guid)
        end
    else
        if combat_event == "SPELL_DAMAGE" and line[id].isDamage then
            return zb_add_icon(bar, length, id, line, src_guid, dst_guid)
        elseif combat_event == "SPELL_CAST_SUCCESS" and line[id].is_success then
            return zb_add_icon(bar, length, id, line, src_guid, dst_guid)
        end
    end
    return length
end

local function zb_is_in_party_alternate(guid)
    local index = 1
    while index < 5 do
        if (UnitGUID("party" .. index) == guid) then
            return true
        end
        index = index + 1
    end
    return false
end

local function zb_is_in_party(guid)
    if party_guid[guid] then
        return true
    end
    return false
end

local function zb_combat_log(...)
    local timestamp, combat_event, _, src_guid, src_name, src_flags, src_raid_flags, dst_guid, dst_name, dst_flags, dst_raid_flags = ...
    local spell_type, spell_name = select(12, ...)
    local spell_id = select(7, GetSpellInfo(spell_name))
    count_delay_from_start = GetTime()
    if is_debugging and (src_guid == (player_guid or UnitGUID("target"))) then
        print(spell_id)
        print(spell_name)
        print(combat_event)
        print(spell_type)
    end
    if is_disabled or (not track_all and src_guid == (player_guid or UnitGUID("target"))) then
        return
    end
    if addonTable.spells_list[spell_id] and addonTable.spells_list[spell_id].is_special_spell then
        specs_by_guid_list[src_guid] = addonTable.special_spells_list[spell_id]
    end
    if addonTable.spells_list[spell_id] and addonTable.spells_list[spell_id].related then
        if bit.band(src_flags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then
            for related_id in pairs(addonTable.spells_list[spell_id].related) do
                length_of_hostile_bar = zb_remove_icon(hostile_bar, length_of_hostile_bar, related_id, true, src_guid)
            end
        elseif zb_is_in_party(src_guid) then
            for related_id in pairs(addonTable.spells_list[spell_id].related) do
                length_of_party_bar = zb_remove_icon(party_bar, length_of_party_bar, related_id, true, src_guid)
            end
        end
    end
    if bit.band(src_flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
        if addonTable.spells_list[spell_id] and bit.band(addonTable.spells_list[spell_id].who, 1) > 0 then 
            if zb_is_in_party(dst_guid) then
                length_of_party_bar = zb_event_type(combat_event, party_bar, length_of_party_bar, spell_id, addonTable.player_spells_list, src_guid, dst_guid)
            else
                length_of_player_bar = zb_event_type(combat_event, player_bar, length_of_player_bar, spell_id, addonTable.player_spells_list, src_guid)
            end
        elseif combat_event == "SWING_MISSED" then
            for id in pairs(addonTable.swing_spells) do
                if (addonTable.swing_spells[id].class == nil or addonTable.swing_spells[id].class == select(2, GetPlayerInfoByGUID(src_guid))) then
                    for swing_type in pairs(addonTable.swing_spells[id].swing_types) do
                        if swing_type == spell_type then
                            length_of_player_bar = zb_add_icon(player_bar, length_of_player_bar, id, addonTable.swing_spells, src_guid)
                            return
                        end
                    end 
                end
            end
        end  
    elseif bit.band(src_flags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then
        if addonTable.spells_list[spell_id] and bit.band(addonTable.spells_list[spell_id].who, 2) > 0 then 
            length_of_hostile_bar = zb_event_type(combat_event, hostile_bar, length_of_hostile_bar, spell_id, addonTable.spells_list, src_guid)
        elseif combat_event == "SWING_MISSED" then
            for id in pairs(addonTable.swing_spells) do
                if (addonTable.swing_spells[id].class == nil or addonTable.swing_spells[id].class == select(2, GetPlayerInfoByGUID(src_guid))) then
                    for swing_type in pairs(addonTable.swing_spells[id].swing_types) do
                        if swing_type == spell_type then
                            length_of_hostile_bar = zb_add_icon(hostile_bar, length_of_hostile_bar, id, addonTable.swing_spells, src_guid)
                            return
                        end
                    end 
                end
            end
        end 
    elseif zb_is_in_party(src_guid) then
        if addonTable.spells_list[spell_id] and bit.band(addonTable.spells_list[spell_id].who, 4) > 0 then 
            length_of_party_bar = zb_event_type(combat_event, party_bar, length_of_party_bar, spell_id, addonTable.spells_list, src_guid)
        elseif combat_event == "SWING_MISSED" then
            for id in pairs(addonTable.swing_spells) do
                if (addonTable.swing_spells[id].class == nil or addonTable.swing_spells[id].class == select(2, GetPlayerInfoByGUID(src_guid))) then
                    for swing_type in pairs(addonTable.swing_spells[id].swing_types) do
                        if swing_type == spell_type then
                            length_of_party_bar = zb_add_icon(party_bar, length_of_party_bar, id, addonTable.swing_spells, src_guid)
                            return
                        end
                    end 
                end
            end
        end 
    end
end

local function zb_initialize_bar(bar, bar_x, bar_y, name)
    bar = CreateFrame("Frame",nil,UIParent)
    bar:SetWidth(square_size*4)
    bar:SetHeight(square_size)
    bar:SetClampedToScreen(true)
    bar:SetPoint("CENTER", UIParent, "CENTER", bar_x, bar_y)
    bar.name = name
    local location
    local icon
    local cooldown
    local texture
    local text
    local index = 1
    while index < total_icons_per_bar do
        
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
        cooldown.noomnicc = true
        cooldown.noCooldownCount = true
        
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

        icon.flasher = icon:CreateAnimationGroup()

        local fade_out = icon.flasher:CreateAnimation("Alpha")
        fade_out:SetDuration(0.5)
        fade_out:SetFromAlpha(1)
        fade_out:SetToAlpha(0.4)
        fade_out:SetOrder(1)

        local fade_in = icon.flasher:CreateAnimation("Alpha")
        fade_in:SetDuration(0.5)
        fade_in:SetToAlpha(1)
        fade_in:SetFromAlpha(0.4)
        fade_in:SetOrder(2)

        icon.flasher:SetLooping("REPEAT")
        icon.is_playing = false

        icon:Hide()
        bar[index] = icon 
        index = index + 1
    end   
    return bar
end

local function zb_clear_spec_list()
    for character in pairs (specs_by_guid_list) do
        specs_by_guid_list[character] = nil
    end
end


local function zb_reset_all(bar, length)
    while length > 1 do
        length = zb_remove_icon(bar, length, 1, false)
    end        
    return length
end

local function zb_entering_world()
    length_of_player_bar = zb_reset_all(player_bar, length_of_player_bar)
    length_of_hostile_bar = zb_reset_all(hostile_bar, length_of_hostile_bar)
    length_of_party_bar = zb_reset_all(party_bar, length_of_party_bar)
end

local function zb_remove_ex_party_member_icons()
    local index = 1
    while index < length_of_party_bar do
        if (party_bar[index].src_guid) then
            if not zb_is_in_party_alternate(party_bar[index].src_guid) then
                length_of_party_bar = zb_remove_icon(party_bar, length_of_party_bar, index, false)
            end
        elseif (party_bar[index].dst_guid and party_bar[index].src_guid == player_guid) then
            if not zb_is_in_party_alternate(party_bar[index].dst_guid) then
                length_of_party_bar = zb_remove_icon(party_bar, length_of_party_bar, index, false)
            end
        end
        index = index + 1
    end
end

local function zb_commands(sub_string)
    if sub_string == "debug" then
        is_debugging = not is_debugging
        if is_debugging then
            print("Debugging on.")
        else 
            print("Debugging off.")
        end
    elseif sub_string == "clear" then
        zb_entering_world()
        zb_clear_spec_list()
    elseif sub_string == "disable" then
        is_disabled = not is_disabled
    elseif sub_string == "all" then
        track_all = not track_all
        if track_all then
            print("Tracking everyone.")
        else 
            print("Tracking target.")
        end
    else
        print("Available commands: Debug, clear, disable, all.")
    end
end

local function zb_on_load(self)
        print("ZB loaded.")
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:RegisterEvent("PLAYER_ENTERING_WORLD")
        self:RegisterEvent("GROUP_ROSTER_UPDATE")
        player_bar = zb_initialize_bar(player_bar, player_bar_x, player_bar_y, "zb_player")
        party_bar = zb_initialize_bar(party_bar, party_bar_x, party_bar_y, "zb_party")
        hostile_bar = zb_initialize_bar(hostile_bar, hostile_bar_x, hostile_bar_y, "zb_hostile")
        SlashCmdList["ZAKATZIBAR"] = zb_commands
        SLASH_ZAKATZIBAR1 = "/zb"
end

local event_handler = {
    ["PLAYER_LOGIN"] = function(self) zb_on_load(self) end,
    ["PLAYER_ENTERING_WORLD"] = function(self) zb_entering_world(self) end,
    ["COMBAT_LOG_EVENT_UNFILTERED"] = function(self) zb_combat_log(CombatLogGetCurrentEventInfo()) end,
    ["GROUP_ROSTER_UPDATE"] = function(self) zb_remove_ex_party_member_icons() end,
}

local function zb_on_event(self,event)
	event_handler[event](self, event)
end

if not zb_frame then 
    CreateFrame("Frame","zb_frame",UIParent)
end
zb_frame:SetScript("OnEvent",zb_on_event)
zb_frame:RegisterEvent("PLAYER_LOGIN")
