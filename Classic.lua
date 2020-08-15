local addonName, addonTable = ...

local wow_version = select(4, GetBuildInfo())
local calc_version_uno = math.floor(wow_version/10000)
local calc_version_dos = wow_version%10000
if (calc_version_uno ~= 1 or calc_version_dos > 10000) then return end

addonTable.spells_list = {
    -- Spells
    -- Warrior
    [1719] = {durations = {1800}, event_type = "success", who = 6}, -- Recklessness
    [12809] = {durations = {45}, event_type = "success", who = 6}, -- Concussion Blow
    [20230] = {durations = {1800}, event_type = "success", who = 6}, -- Retaliation
    [72] = {durations = {12}, event_type = "success", who = 6}, -- Shield Bash
    [871] = {durations = {1800}, event_type = "success", who = 6}, -- Shield Wall
    [6552] = {durations = {10}, event_type = "success", who = 6}, -- Pummel
    [18499] = {durations={30}, event_type = "success", who = 6}, -- Berserker Rage
    [12328] = {durations={180}, event_type = "success", who = 6}, -- Death Wish
    -- Paladin
    [20066] = {durations={60}, event_type = "success", who = 6}, -- Repentance
    [498] = {durations={300}, event_type = "success", who = 6}, -- Divine Protection
    [853] = {durations={45}, event_type = "success", who = 6}, -- Hammer of Justice
    [1022] = {durations={180}, event_type = "success", who = 6}, -- Blessing of Protection
    [1044] = {durations={20}, event_type = "success", who = 6}, -- Blessing of Freedom
    -- Rogue
    [11286] = {durations={10}, event_type = "success", who = 6}, -- Gouge
    [1769] = {durations={10}, event_type = "success", who = 6}, -- Kick
    [408] = {durations={20}, event_type = "success", who = 6}, -- Kidney Shot
    [2983] = {durations={180}, event_type = "success", who = 6}, -- Sprint
    [13877] = {durations={120}, event_type = "success", who = 6}, -- Blade Flurry
    [14278] = {durations={20}, event_type = "success", who = 6}, -- Ghostly Strike
    [2094] = {durations={180}, event_type = "success", who = 6}, -- Blind
    [14183] = {durations={120}, event_type = "success", who = 6}, -- Premeditation
    [5277] = {durations={180}, event_type = "success", who = 6}, -- Evasion
    [13750] = {durations={300}, event_type = "success", who = 6}, -- Adrenaline Rush
    [14185] = {durations = {600}, related = {13750, 5277, 14183, 2094, 14278, 11286, 1769, 408, 2983, 13877}, event_type = "success", who = 6}, -- Preparation
    -- Priest
    [10060] = {durations={180}, event_type = "success", who = 6}, -- Power Infusion
    [15487] = {durations={45}, event_type = "success", who = 6}, -- Silence
    [8122] = {durations={26}, event_type = "success", who = 6}, -- Psychic Scream
    --Mage
    [543] = {durations={30}, event_type = "success", who = 6}, -- Fire Ward
    [11958] = {durations={300}, event_type = "success", who = 6}, -- Ice Block
    [122] = {durations={21}, event_type = "success", who = 6}, -- Frost Nova
    [6143] = {durations={30}, event_type = "success", who = 6}, -- Frost Ward
    [2139] = {durations={30}, event_type = "success", who = 6}, -- Counterspell
    [11426] = {durations={30}, event_type = "success", who = 6}, -- Ice Barrier
    [12042] = {durations={180}, event_type = "success", who = 6}, -- Arcane Power
    [12051] = {durations={420}, event_type = "success", who = 6}, -- Evocation
    [12472] = {durations = {600}, related = {11958, 122, 6143, 11426}, event_type = "success", who = 6}, -- COLD SNAP
    -- Warlock
    [6229] = {durations={30}, event_type = "success", who = 6}, -- Shadow Ward
    [6789] = {durations={102}, event_type = "success", who = 6}, -- Death Coil
    [5484] = {durations={40}, event_type = "success", who = 6}, -- Howl of Terror
    [19244] = {durations={30}, event_type = "success", who = 6}, -- Spell Lock
    -- Shaman
    [8042] = {durations={5}, event_type = "success", who = 6}, -- Earth Shock
    [8177] = {durations={13}, event_type = "success", who = 6}, -- Grounding Totem
    [16188] = {durations={180}, event_type = "success", who = 6}, -- Nature's Swiftness
    -- Druid
    [5211] = {durations={60}, event_type = "success", who = 6}, -- Bash
    [1850] = {durations={300}, event_type = "success", who = 6}, -- Dash
    [16979] = {durations={15}, event_type = "success", who = 6}, -- Feral Charge
    [29166] = {durations={360}, event_type = "success", who = 6}, -- Innervate
    [16689] = {durations={60}, event_type = "success", who = 6}, -- Nature's Grasp
    [22812] = {durations={60}, event_type = "success", who = 6}, -- Barkskin
    -- Hunter
    [19574] = {durations={120}, event_type = "success", who = 6}, -- Bestial Wrath
    [19503] = {durations={30}, event_type = "success", who = 6}, -- Scatter Shot
    [25999] = {durations={25}, event_type = "success", who = 6}, -- Boar Charge
    [3045] = {durations={180}, event_type = "success", who = 6}, -- Rapid Fire
    [19263] = {durations={300}, event_type = "success", who = 6}, -- Deterrence
    [19386] = {durations={120}, event_type = "success", who = 6}, -- Wyvern Sting
    [1499] = {durations={15}, event_type = "success", who = 6}, -- Freezing Trap
    -- End
}

addonTable.swing_spells = {}
