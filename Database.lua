local addonName, addonTable = ...

local wow_version = select(4, GetBuildInfo())
--print(wow_version)
local calc_version_uno = math.floor(wow_version/20000)
local calc_version_dos = wow_version%20000
--print(calc_version_uno ~= 1 or calc_version_dos > 10000)
if (calc_version_uno ~= 1 or calc_version_dos > 10000) then return end

-- a quick guide to the variable "trigger_groups"
-- when a spell is in the list, if it is cast, it will always be evaluated
-- the "who" variable decides whether or not the addon user WANTS the variable to BE evaluated for a particular target type (party, self, hostile)
-- it does that through a bit operation. 1 for self, 2 for party, 4 for hostile. u can add those numbers depending on which types u want the spell to be tracked for.

addonTable.spells_list = {
  --[11285] = {durations = {5}, event_type = "success", who=7, spells_that_also_go_on_cooldown = { {id = 20473, duration = 7.6}}}, -- DEV_ITEM
  -- Rogue
  [14185] = {durations = {600}, event_type = "success", trigger_groups=6, spells_that_are_removed_from_cooldown={14177, 36554, 2983, 1856, 14183, 5277}},
  [1776] = {durations = {9}, event_type = "success", trigger_groups=6}, -- Gouge
  [1766] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Kick
  [1725] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Distract
  [1966] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Feint
  [408] = {durations = {20}, event_type = "success", trigger_groups=6}, -- Kidney Shot
  [36554] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Shadowstep
  [2983] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Sprint
  [1784] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Stealth
  [1856] = {durations = {360}, event_type = "success", trigger_groups=6}, -- Vanish
  [14251] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Riposte
  [13877] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Blade Flurry
  [14278] = {durations = {20}, event_type = "success", trigger_groups=6}, -- Ghostly Strike
  [2094] = {durations = {90}, event_type = "success", trigger_groups=6}, -- Blind
  [14183] = {durations = {120}, event_type = "success", trigger_groups=7}, -- Premeditation
  [5277] = {durations = {210}, event_type = "success", trigger_groups=6}, -- Evasion
  [14177] = {durations = {180}, event_type = "cooldown_on_remove", trigger_groups=6}, -- Cold Blood
  [31224] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Cloak of Shadows
  [13750] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Adrenaline Rush
  -- Druid
  [5215] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Prowl
  [22842] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Frenzied Regeneration
  [5211] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Bash
  [5209] = {durations = {600}, event_type = "success", trigger_groups=6}, -- Challenging Roar
  [8998] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Cower
  [1850] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Dash
  [5229] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Enrage
  [33831] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Force of Nature
  [33878] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Mangle (Bear)
  [16979] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Feral Charge
  [6795] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Growl
  [18562] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Swiftmend
  [16914] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Hurricane
  [16857] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Faerie Fire (Feral)
  [29166] = {durations = {360}, event_type = "success", trigger_groups=6}, -- Innervate
  [16689] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Nature's Grasp
  [17116] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Nature's Swiftness
  [20484] = {durations = {1200}, event_type = "success", trigger_groups=6}, -- Rebirth
  [22812] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Barkskin
  [740] = {durations = {600}, event_type = "success", trigger_groups=6}, -- Tranquility
  -- Hunter
  [19577] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Intimidate
  [1742] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Cower
  [1513] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Scare Beast
  [23099] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Dash
  [19574] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Bestial Wrath
  [24450] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Prowl
  [19503] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Scatter Shot
  [3034] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Viper Sting
  [34026] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Kill Command
  [34477] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Misdirection
  [7371] = {durations = {25}, event_type = "success", trigger_groups=6}, -- Charge
  [26090] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Thunderstomp
  [26064] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Shellshield
  [24604] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Furious Howl
  [23989] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Readiness
  [3045] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Rapid Fire
  [34600] = {durations = {24}, event_type = "success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 13795, duration = 24},{id = 13813, duration = 24},{id = 1499, duration = 24},{id = 13809, duration = 24},}}, -- Snake Trap
  [13795] = {durations = {24}, event_type = "success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 34600, duration = 24},{id = 13813, duration = 24},{id = 1499, duration = 24},{id = 13809, duration = 24},}}, -- Immolation Trap
  [13813] = {durations = {24}, event_type = "success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 13795, duration = 24},{id = 34600, duration = 24},{id = 13813, duration = 24},{id = 1499, duration = 24},}}, -- Explosive Trap
  [1499] = {durations = {24}, event_type = "success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 13795, duration = 24},{id = 34600, duration = 24},{id = 13813, duration = 24},{id = 1499, duration = 24},}}, -- Freezing Trap
  [13809] = {durations = {24}, event_type = "success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 13795, duration = 24},{id = 34600, duration = 24},{id = 13813, duration = 24},{id = 1499, duration = 24},}}, -- Frost Trap
  [1495] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Mongoose Bite THIS IS A SWING EVENT
  [3044] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Arcane Shot
  [1510] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Volley
  [2973] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Raptor Strike
  [2649] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Growl
  [24640] = {durations = {4}, event_type = "success", trigger_groups=6}, -- Scorpid Poison
  [17253] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Bite
  [5384] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Feign Death
  [781] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Disengage
  [34490] = {durations = {20}, event_type = "success", trigger_groups=6}, -- Silencing Shot
  [2643] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Multi Shot
  [19306] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Counterattack
  [19263] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Deterrence
  [19386] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Wyvern Sting
  [19434] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Aimed Shot
  [35346] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Warp
  [20736] = {durations = {8}, event_type = "success", trigger_groups=6}, -- Distracting Shot
  [34889] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Fire Breath
  [1543] = {durations = {20}, event_type = "success", trigger_groups=6}, -- Flare
  [5116] = {durations = {11}, event_type = "success", trigger_groups=6}, -- Concussive Shot
  [35387] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Poison Spit
  [19801] = {durations = {20}, event_type = "success", trigger_groups=6}, -- Tranquilizing Shot
  [23145] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Dive
  -- Mage
  [66] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Invisibility
  [31661] = {durations = {20}, event_type = "success", trigger_groups=6}, -- Dragon's Breath
  [1953] = {durations = {13}, event_type = "success", trigger_groups=6}, -- Blink
  [43987] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Ritual of Refreshment
  [543] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Fireward
  [2136] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Fire Blast
  [11129] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Combustion
  [12472] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Icy Veins
  [45438] = {durations = {240}, event_type = "success", trigger_groups=6}, -- Iceblock
  [122] = {durations = {21}, event_type = "success", trigger_groups=6}, -- Frost Nova
  [6143] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Frost Ward
  [120] = {durations = {8}, event_type = "success", trigger_groups=6}, -- Cone of Cold
  [2139] = {durations = {24}, event_type = "success", trigger_groups=6}, -- Counterspell
  [31687] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Summon Water Elemental
  [11958] = {durations = {384}, event_type = "success", trigger_groups=6, spells_that_are_removed_from_cooldown={120, 6143, 122, 45438, 12472, 31687, 11426}}, -- Cold Snap
  [11426] = {durations = {24}, event_type = "success", trigger_groups=6}, -- Ice Barrier
  [11113] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Blast Wave
  [12043] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Presence of Mind
  [12042] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Arcane Power
  [12051] = {durations = {480}, event_type = "success", trigger_groups=6}, -- Evocation
  -- Paladin
  [24275] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Hammer of Wrath
  [31789] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Righteous Defense
  [31935] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Avenger's Shield
  [31884] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Avenging Wrath
  [20925] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Holy Shield
  [35395] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Crusader Strike
  [31842] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Divine Illumination
  [642] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Divine Shield
  [2812] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Holy Wrath
  [879] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Exorcism
  [20216] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Divine Favor
  [26573] = {durations = {8}, event_type = "success", trigger_groups=6}, -- Consecration
  [633] = {durations = {2400}, event_type = "success", trigger_groups=6}, -- Lay on Hands
  [20066] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Repentance
  [498] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Divine Protection
  [20271] = {durations = {8}, event_type = "success", trigger_groups=6}, -- Judgement
  [853] = {durations = {45}, event_type = "success", trigger_groups=6}, -- Hammer of Justice
  [1022] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Blessing of Protection
  [6940] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Blessing of Sacrifice
  [1044] = {durations = {25}, event_type = "success", trigger_groups=6}, -- Blessing of Freedom
  [20473] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Holy Shock
  [10326] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Turn Evil
  [2878] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Turn Undead
  -- Priest
  [10797] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Starshards
  [32676] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Consume Magic
  [14751] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Inner Focus
  [44041] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Chastise
  [2651] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Elune's Grace
  [6346] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Fear Ward
  [33206] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Pain Suppression
  [10060] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Power Infusion
  [17] = {durations = {4}, event_type = "success", trigger_groups=6}, -- Power Word: Shield
  [33076] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Prayer of Mending
  [13908] = {durations = {600}, event_type = "success", trigger_groups=6}, -- Desperate Prayer
  [724] = {durations = {360}, event_type = "success", trigger_groups=6}, -- Lightwell
  [32548] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Symbol of Hope
  [586] = {durations = {24}, event_type = "success", trigger_groups=6}, -- Fade
  [2944] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Devouring Plague
  [32379] = {durations = {12}, event_type = "success", trigger_groups=6}, -- Shadow Word: Death
  [15487] = {durations = {45}, event_type = "success", trigger_groups=6}, -- Silence
  [8122] = {durations = {26}, event_type = "success", trigger_groups=6}, -- Psychic Scream
  [13896] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Feedback
  [34433] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Shadowfiend
  [8092] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Mind Blast
  [15286] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Vampiric Embrace
  -- Shaman
  [32182] = {durations = {600}, event_type = "success", trigger_groups=6}, -- Heroism
  [17364] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Stormstrike
  [2894] = {durations = {1200}, event_type = "success", trigger_groups=6}, -- Fire Elemental Totem
  [1535] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Fire Nova Totem
  [16190] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Mana Tide Totem
  [2825] = {durations = {600}, event_type = "success", trigger_groups=6}, -- Bloodlust
  [2062] = {durations = {2400}, event_type = "success", trigger_groups=6}, -- Earth Elemental Totem
  [421] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Chain Lightning
  [8042] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Earth Shock
  [8177] = {durations = {13}, event_type = "success", trigger_groups=6}, -- Grounding Totem
  [16188] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Nature's Swiftness
  [20608] = {durations = {2400}, event_type = "success", trigger_groups=6}, -- Reincarnation
  [30823] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Shamanistic Rage
  [5730] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Stoneclaw Totem
  [2484] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Earthbind Totem
  [16166] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Elemental Mastery
  -- Warlock
  [29858] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Soulshatter
  [17962] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Conflagrate
  [6353] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Soulfire
  [19505] = {durations = {8}, event_type = "success", trigger_groups=6}, -- Devour Magic
  [18708] = {durations = {900}, event_type = "success", trigger_groups=6}, -- Fel Domination
  [6229] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Shadow Ward
  [603] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Curse of Doom
  [17735] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Suffering
  [18288] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Amplify Curse
  [7814] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Lash of Pain
  [6789] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Death Coil
  [5484] = {durations = {40}, event_type = "success", trigger_groups=6}, -- Howl of Terror
  [3716] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Torment
  [4511] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Phase Shift
  [19244] = {durations = {24}, event_type = "success", trigger_groups=6}, -- Spell Lock
  [17877] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Shadowburn
  [29893] = {durations = {300}, event_type = "success", trigger_groups=6}, -- Ritual of Souls
  [30283] = {durations = {20}, event_type = "success", trigger_groups=6}, -- Shadowfury
  [6360] = {durations = {4}, event_type = "success", trigger_groups=6}, -- Soothing Kiss
  -- Warrior
  [1161] = {durations = {420}, event_type = "success", trigger_groups=6}, -- Challenging Shout
  [1719] = {durations = {1200}, event_type = "success", trigger_groups=6}, -- Recklessness
  [2565] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Shield Block
  [5246] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Intimidating Shout
  [7384] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Overpower
  [2687] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Bloodrage
  [12328] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Sweeping Strikes
  [20252] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Intercept
  [12809] = {durations = {45}, event_type = "success", trigger_groups=6}, -- Concussion Blow
  [20230] = {durations = {1200}, event_type = "success", trigger_groups=6}, -- Retaliation
  [100] = {durations = {15}, event_type = "success", trigger_groups=6}, -- Charge
  [676] = {durations = {60}, event_type = "success", trigger_groups=6}, -- Disarm
  [694] = {durations = {120}, event_type = "success", trigger_groups=6}, -- Mocking Blow
  [6572] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Revenge
  [12294] = {durations = {5}, event_type = "success", trigger_groups=6}, -- Mortal Strike
  [72] = {durations = {12}, event_type = "success", trigger_groups=6}, -- Shield Bash
  [23920] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Spell Reflection
  [871] = {durations = {1200}, event_type = "success", trigger_groups=6}, -- Shield Wall
  [3411] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Intervene
  [1680] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Whirlwind
  [6552] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Pummel
  [23922] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Shield Slam
  [12975] = {durations = {480}, event_type = "success", trigger_groups=6}, -- Last Stand
  [18499] = {durations = {30}, event_type = "success", trigger_groups=6}, -- Berserker Rage
  [23881] = {durations = {6}, event_type = "success", trigger_groups=6}, -- Bloodthirst
  [355] = {durations = {10}, event_type = "success", trigger_groups=6}, -- Taunt
  [6343] = {durations = {4}, event_type = "success", trigger_groups=6}, -- Thunderclap
  [12292] = {durations = {180}, event_type = "success", trigger_groups=6}, -- Death Wish
}

addonTable.swing_spells = {}
