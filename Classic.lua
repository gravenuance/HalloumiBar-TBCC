local addonName, addonTable = ...

local wow_version = select(4, GetBuildInfo())
local calc_version_uno = math.floor(wow_version/10000)
local calc_version_dos = wow_version%10000
if (calc_version_uno ~= 1 or calc_version_dos > 10000) return end

addonTable.spells_list = {

    -- Spells
    -- Warrior
    [1719] = {duration = 1800, is_success = true} -- Recklessness
    [12809] = {duration = 45, is_success = true } -- Concussion Blow
    [20230] = {duration = 1800, is_success = true} -- Retaliation
    [72] = {duration = 12, is_success = true} -- Shield Bash
    [871] = {duration = 1800, is_success = true} -- Shield Wall
    [6552] = {duration = 10, is_success = true} -- Pummel
    [18499] = {duration=30, is_success=true} -- Berserker Rage
    [12328] = {duration=180, is_success=true} -- Death Wish
    -- Paladin
    [20066] = {duration=60, is_success=true} -- Repentance
    [498] = {duration=300, is_success=true} -- Divine Protection
    [853] = {duration=45, is_success=true} -- Hammer of Justice
    [1022] = {duration=180, is_success=true} -- Blessing of Protection
    [1044] = {duration=20, is_success=true} -- Blessing of Freedom
    -- Rogue
    [11286] = {duration=10, is_success=true} -- Gouge
    [1769] = {duration=10, is_success=true} -- Kick
    [408] = {duration=20, is_success=true} -- Kidney Shot
    [2983] = {duration=180, is_success=true} -- Sprint
    [13877] = {duration=120, is_success=true} -- Blade Flurry
    [14278] = {duration=20, is_success=true} -- Ghostly Strike
    [2094] = {duration=180, is_success=true} -- Blind
    [14183] = {duration=120, is_success=true} -- Premeditation
    [5277] = {duration=180, is_success=true} -- Evasion
    [13750] = {duration=300, is_success=true} -- Adrenaline Rush
    [14185] = {duration = 600, related = {13750, 5277, 14183, 2094, 14278, 11286, 1769, 408, 2983, 13877}, is_success = true} -- Preparation
    -- Priest
    [10060] = {duration=180, is_success=true} -- Power Infusion
    [15487] = {duration=45, is_success=true} -- Silence
    [8122] = {duration=26, is_success=true} -- Psychic Scream
    --Mage
    [543] = {duration=30, is_success=true} -- Fire Ward
    [11958] = {duration=300, is_success=true} -- Ice Block
    [122] = {duration=21, is_success=true} -- Frost Nova
    [6143] = {duration=30, is_success=true} -- Frost Ward
    [2139] = {duration=30, is_success=true} -- Counterspell
    [11426] = {duration=30, is_success=true} -- Ice Barrier
    [12042] = {duration=180, is_success=true} -- Arcane Power
    [12051] = {duration=420, is_success=true} -- Evocation
    [12472] = {duration = 600, related = {11958, 122, 6143, 11426}, is_success = true} -- COLD SNAP
    -- Warlock
    [6229] = {duration=30, is_success=true} -- Shadow Ward
    [6789] = {duration=102, is_success=true} -- Death Coil
    [5484] = {duration=40, is_success=true} -- Howl of Terror
    [19244] = {duration=30, is_success=true} -- Spell Lock
    -- Shaman
    [8042] = {duration=5, is_success=true} -- Earth Shock
    [8177] = {duration=13, is_success=true} -- Grounding Totem
    [16188] = {duration=180, is_success=true} -- Nature's Swiftness
    -- Druid
    [5211] = {duration=60, is_success=true} -- Bash
    [1850] = {duration=300, is_success=true} -- Dash
    [16979] = {duration=15, is_success=true} -- Feral Charge
    [29166] = {duration=360, is_success=true} -- Innervate
    [16689] = {duration=60, is_success=true} -- Nature's Grasp
    [22812] = {duration=60, is_success=true} -- Barkskin
    -- Hunter
    [19574] = {duration=120, is_success=true} -- Bestial Wrath
    [19503] = {duration=30, is_success=true} -- Scatter Shot
    [25999] = {duration=25, is_success=true} -- Boar Charge
    [3045] = {duration=180, is_success=true} -- Rapid Fire
    [19263] = {duration=300, is_success=true} -- Deterrence
    [19386] = {duration=120, is_success=true} -- Wyvern Sting
    [1499] = {duration=15, is_success=true} -- Freezing Trap
    -- End

}
    

addonTable.player_spells_list = {}

addonTable.special_spells_list = {}
