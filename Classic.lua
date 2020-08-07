local addonName, addonTable = ...

local wow_version = select(4, GetBuildInfo())
local calc_version_uno = math.floor(wow_version/10000)
local calc_version_dos = wow_version%10000
if (calc_version_uno ~= 1 or calc_version_dos > 10000) then return end

addonTable.spells_list = {
    -- Spells
    -- Warrior
    [1719] = {duration = 1800, is_success = true, who = 7}, -- Recklessness
    [12809] = {duration = 45, is_success = true, who = 7}, -- Concussion Blow
    [20230] = {duration = 1800, is_success = true, who = 7}, -- Retaliation
    [72] = {duration = 12, is_success = true, who = 7}, -- Shield Bash
    [871] = {duration = 1800, is_success = true, who = 7}, -- Shield Wall
    [6552] = {duration = 10, is_success = true, who = 7}, -- Pummel
    [18499] = {duration=30, is_success=true, who = 7}, -- Berserker Rage
    [12328] = {duration=180, is_success=true, who = 7}, -- Death Wish
    -- Paladin
    [20066] = {duration=60, is_success=true, who = 7}, -- Repentance
    [498] = {duration=300, is_success=true, who = 7}, -- Divine Protection
    [853] = {duration=45, is_success=true, who = 7}, -- Hammer of Justice
    [1022] = {duration=180, is_success=true, who = 7}, -- Blessing of Protection
    [1044] = {duration=20, is_success=true, who = 7}, -- Blessing of Freedom
    -- Rogue
    [11286] = {duration=10, is_success=true, who = 7}, -- Gouge
    [1769] = {duration=10, is_success=true, who = 7}, -- Kick
    [408] = {duration=20, is_success=true, who = 7}, -- Kidney Shot
    [2983] = {duration=180, is_success=true, who = 7}, -- Sprint
    [13877] = {duration=120, is_success=true, who = 7}, -- Blade Flurry
    [14278] = {duration=20, is_success=true, who = 7}, -- Ghostly Strike
    [2094] = {duration=180, is_success=true, who = 7}, -- Blind
    [14183] = {duration=120, is_success=true, who = 7}, -- Premeditation
    [5277] = {duration=180, is_success=true, who = 7}, -- Evasion
    [13750] = {duration=300, is_success=true, who = 7}, -- Adrenaline Rush
    [14185] = {duration = 600, related = {13750, 5277, 14183, 2094, 14278, 11286, 1769, 408, 2983, 13877}, is_success = true, who = 7}, -- Preparation
    -- Priest
    [10060] = {duration=180, is_success=true, who = 7}, -- Power Infusion
    [15487] = {duration=45, is_success=true, who = 7}, -- Silence
    [8122] = {duration=26, is_success=true, who = 7}, -- Psychic Scream
    --Mage
    [543] = {duration=30, is_success=true, who = 7}, -- Fire Ward
    [11958] = {duration=300, is_success=true, who = 7}, -- Ice Block
    [122] = {duration=21, is_success=true, who = 7}, -- Frost Nova
    [6143] = {duration=30, is_success=true, who = 7}, -- Frost Ward
    [2139] = {duration=30, is_success=true, who = 7}, -- Counterspell
    [11426] = {duration=30, is_success=true, who = 7}, -- Ice Barrier
    [12042] = {duration=180, is_success=true, who = 7}, -- Arcane Power
    [12051] = {duration=420, is_success=true, who = 7}, -- Evocation
    [12472] = {duration = 600, related = {11958, 122, 6143, 11426}, is_success = true, who = 7}, -- COLD SNAP
    -- Warlock
    [6229] = {duration=30, is_success=true, who = 7}, -- Shadow Ward
    [6789] = {duration=102, is_success=true, who = 7}, -- Death Coil
    [5484] = {duration=40, is_success=true, who = 7}, -- Howl of Terror
    [19244] = {duration=30, is_success=true, who = 7}, -- Spell Lock
    -- Shaman
    [8042] = {duration=5, is_success=true, who = 7}, -- Earth Shock
    [8177] = {duration=13, is_success=true, who = 7}, -- Grounding Totem
    [16188] = {duration=180, is_success=true, who = 7}, -- Nature's Swiftness
    -- Druid
    [5211] = {duration=60, is_success=true, who = 7}, -- Bash
    [1850] = {duration=300, is_success=true, who = 7}, -- Dash
    [16979] = {duration=15, is_success=true, who = 7}, -- Feral Charge
    [29166] = {duration=360, is_success=true, who = 7}, -- Innervate
    [16689] = {duration=60, is_success=true, who = 7}, -- Nature's Grasp
    [22812] = {duration=60, is_success=true, who = 7}, -- Barkskin
    -- Hunter
    [19574] = {duration=120, is_success=true, who = 7}, -- Bestial Wrath
    [19503] = {duration=30, is_success=true, who = 7}, -- Scatter Shot
    [25999] = {duration=25, is_success=true, who = 7}, -- Boar Charge
    [3045] = {duration=180, is_success=true, who = 7}, -- Rapid Fire
    [19263] = {duration=300, is_success=true, who = 7}, -- Deterrence
    [19386] = {duration=120, is_success=true, who = 7}, -- Wyvern Sting
    [1499] = {duration=15, is_success=true, who = 7}, -- Freezing Trap
    -- End
}

addonTable.swing_spells = {}
