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
  --[11285] = {durations = {5}, event_type = "cast_success", who=7, spells_that_also_go_on_cooldown = { {id = 20473, duration = 7.6}}}, -- DEV_ITEM
  -- Rogue
  [14185] = {durations = {600}, event_type = "cast_success", trigger_groups=6, spells_that_are_removed_from_cooldown={14177, 36554, 11305, 26889, 14183, 26669}}, -- Preparation
  [38764] = {durations = {9}, event_type = "spell_damage", trigger_groups=6}, -- Gouge
  [38768] = {durations = {10}, event_type = "spell_damage", trigger_groups=6}, -- Kick
  [1725] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Distract
  [27448] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Feint
  [8643] = {durations = {20}, event_type = "cast_success", trigger_groups=6}, -- Kidney Shot
  [36554] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Shadowstep
  [11305] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Sprint
  [1787] = {durations = {5}, event_type = "cooldown_on_remove", trigger_groups=6}, -- Stealth
  [26889] = {durations = {360}, event_type = "cast_success", trigger_groups=6}, -- Vanish
  [14251] = {durations = {6}, event_type = "spell_damage", trigger_groups=6}, -- Riposte
  [13877] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Blade Flurry
  [14278] = {durations = {20}, event_type = "spell_damage", trigger_groups=6}, -- Ghostly Strike
  [2094] = {durations = {90}, event_type = "cast_success", trigger_groups=6}, -- Blind
  [14183] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Premeditation
  [26669] = {durations = {210}, event_type = "cast_success", trigger_groups=6}, -- Evasion
  [14177] = {durations = {180}, event_type = "cooldown_on_remove", trigger_groups=6}, -- Cold Blood
  [31224] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Cloak of Shadows
  [13750] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Adrenaline Rush
  -- Druid
  [9913] = {durations = {10}, event_type = "cooldown_on_remove", trigger_groups=7}, -- Prowl
  [26999] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Frenzied Regeneration
  [8983] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Bash
  [5209] = {durations = {600}, event_type = "cast_success", trigger_groups=6}, -- Challenging Roar
  [27048] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Cower
  [33357] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Dash
  [5229] = {durations = {60}, event_type = "cast_success", trigger_groups=1}, -- Enrage
  [33831] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Force of Nature
  [33987] = {durations = {6}, event_type = "cast_success", trigger_groups=7}, -- Mangle (Bear)
  [16979] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Feral Charge
  [27047] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Growl
  [18562] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Swiftmend
  [27012] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Hurricane
  [27011] = {durations = {6}, event_type = "cast_success", trigger_groups=7}, -- Faerie Fire (Feral)
  [29166] = {durations = {360}, event_type = "cast_success", trigger_groups=6}, -- Innervate
  [27009] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Nature's Grasp
  [17116] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Nature's Swiftness
  [26994] = {durations = {1200}, event_type = "cast_success", trigger_groups=6}, -- Rebirth
  [22812] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Barkskin
  [26983] = {durations = {600}, event_type = "cast_success", trigger_groups=6}, -- Tranquility
  -- Hunter
  [14327] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Scare Beast
  [19574] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Bestial Wrath
  [19503] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Scatter Shot
  [27018] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Viper Sting
  [34026] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Kill Command
  [34477] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Misdirection
  [27685] = {durations = {25}, event_type = "cast_success", trigger_groups=6}, -- Charge
  [23989] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Readiness
  [3045] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Rapid Fire
  [34600] = {durations = {24}, event_type = "cast_success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 27023, duration = 24},{id = 27025, duration = 24},{id = 14311, duration = 24},{id = 13809, duration = 24},}}, -- Snake Trap
  [27023] = {durations = {24}, event_type = "cast_success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 34600, duration = 24},{id = 27025, duration = 24},{id = 14311, duration = 24},{id = 13809, duration = 24},}}, -- Immolation Trap
  [27025] = {durations = {24}, event_type = "cast_success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 27023, duration = 24},{id = 34600, duration = 24},{id = 13809, duration = 24},{id = 14311, duration = 24},}}, -- Explosive Trap
  [14311] = {durations = {24}, event_type = "cast_success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 27023, duration = 24},{id = 34600, duration = 24},{id = 27025, duration = 24},{id = 13809, duration = 24},}}, -- Freezing Trap
  [13809] = {durations = {24}, event_type = "cast_success", trigger_groups=6, spells_that_also_go_on_cooldown={{id = 27023, duration = 24},{id = 34600, duration = 24},{id = 27025, duration = 24},{id = 14311, duration = 24},}}, -- Frost Trap
  [36916] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Mongoose Bite THIS IS A SWING EVENT
  [27019] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Arcane Shot
  [27022] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Volley
  [27014] = {durations = {6}, event_type = "cast_success", trigger_groups=6}, -- Raptor Strike
  [5384] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Feign Death
  [27015] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Disengage
  [34490] = {durations = {20}, event_type = "cast_success", trigger_groups=6}, -- Silencing Shot
  [27021] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Multi-Shot
  [27067] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Counterattack
  [19263] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Deterrence
  [27068] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Wyvern Sting
  [27065] = {durations = {6}, event_type = "cast_success", trigger_groups=6}, -- Aimed Shot
  [27020] = {durations = {8}, event_type = "cast_success", trigger_groups=6}, -- Distracting Shot
  [1543] = {durations = {20}, event_type = "cast_success", trigger_groups=6}, -- Flare
  [5116] = {durations = {11}, event_type = "cast_success", trigger_groups=6}, -- Concussive Shot
  [19801] = {durations = {20}, event_type = "cast_success", trigger_groups=6}, -- Tranquilizing Shot
  -- Mage
  [66] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Invisibility
  [33043] = {durations = {20}, event_type = "cast_success", trigger_groups=6}, -- Dragon's Breath
  [1953] = {durations = {13}, event_type = "cast_success", trigger_groups=6}, -- Blink
  [27128] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Fireward
  [27079] = {durations = {6}, event_type = "cast_success", trigger_groups=6}, -- Fire Blast
  [11129] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Combustion
  [12472] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Icy Veins
  [45438] = {durations = {240}, event_type = "cast_success", trigger_groups=6}, -- Ice block
  [27088] = {durations = {21}, event_type = "cast_success", trigger_groups=6}, -- Frost Nova
  [32796] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Frost Ward
  [27087] = {durations = {8}, event_type = "cast_success", trigger_groups=6}, -- Cone of Cold
  [2139] = {durations = {24}, event_type = "cast_success", trigger_groups=6}, -- Counterspell
  [31687] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Summon Water Elemental
  [11958] = {durations = {384}, event_type = "cast_success", trigger_groups=6, spells_that_are_removed_from_cooldown={27087, 32796, 27088, 45438, 12472, 31687, 33405}}, -- Cold Snap
  [33405] = {durations = {24}, event_type = "cast_success", trigger_groups=6}, -- Ice Barrier
  [33933] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Blast Wave
  [12043] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Presence of Mind
  [12042] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Arcane Power
  [12051] = {durations = {480}, event_type = "cast_success", trigger_groups=6}, -- Evocation
  -- Paladin
  [27180] = {durations = {6}, event_type = "cast_success", trigger_groups=6}, -- Hammer of Wrath
  [31789] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Righteous Defense
  [32700] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Avenger's Shield
  [31884] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Avenging Wrath
  [27179] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Holy Shield
  [35395] = {durations = {6}, event_type = "cast_success", trigger_groups=6}, -- Crusader Strike
  [31842] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Divine Illumination
  [1020] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Divine Shield
  [27139] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Holy Wrath
  [27138] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Exorcism
  [20216] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Divine Favor
  [27173] = {durations = {8}, event_type = "cast_success", trigger_groups=6}, -- Consecration
  [27154] = {durations = {2400}, event_type = "cast_success", trigger_groups=6}, -- Lay on Hands
  [20066] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Repentance
  [5573] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Divine Protection
  [20271] = {durations = {8}, event_type = "cast_success", trigger_groups=6}, -- Judgement
  [10308] = {durations = {45}, event_type = "cast_success", trigger_groups=6}, -- Hammer of Justice
  [10278] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Blessing of Protection
  [27148] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Blessing of Sacrifice
  [1044] = {durations = {25}, event_type = "cast_success", trigger_groups=6}, -- Blessing of Freedom
  [33072] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Holy Shock
  [10326] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Turn Evil
  [5627] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Turn Undead
  -- Priest
  [25446] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Starshards
  [32676] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Consume Magic
  [14751] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Inner Focus
  [44047] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Chastise
  [2651] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Elune's Grace
  [6346] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Fear Ward
  [33206] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Pain Suppression
  [10060] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Power Infusion
  [25218] = {durations = {4}, event_type = "cast_success", trigger_groups=6}, -- Power Word: Shield
  [33076] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Prayer of Mending
  [25437] = {durations = {600}, event_type = "cast_success", trigger_groups=6}, -- Desperate Prayer
  [28275] = {durations = {360}, event_type = "cast_success", trigger_groups=6}, -- Lightwell
  [32548] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Symbol of Hope
  [25429] = {durations = {24}, event_type = "cast_success", trigger_groups=6}, -- Fade
  [25467] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Devouring Plague
  [32996] = {durations = {12}, event_type = "cast_success", trigger_groups=6}, -- Shadow Word: Death
  [15487] = {durations = {45}, event_type = "cast_success", trigger_groups=6}, -- Silence
  [10890] = {durations = {26}, event_type = "cast_success", trigger_groups=6}, -- Psychic Scream
  [25441] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Feedback
  [34433] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Shadowfiend
  [25375] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Mind Blast
  [15286] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Vampiric Embrace
  -- Shaman
  [32182] = {durations = {600}, event_type = "cast_success", trigger_groups=6}, -- Heroism
  [17364] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Stormstrike
  [2894] = {durations = {1200}, event_type = "cast_success", trigger_groups=6}, -- Fire Elemental Totem
  [25547] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Fire Nova Totem
  [16190] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Mana Tide Totem
  [2825] = {durations = {600}, event_type = "cast_success", trigger_groups=6}, -- Bloodlust
  [2062] = {durations = {2400}, event_type = "cast_success", trigger_groups=6}, -- Earth Elemental Totem
  [25442] = {durations = {6}, event_type = "cast_success", trigger_groups=6}, -- Chain Lightning
  [25454] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Earth Shock
  [8177] = {durations = {13}, event_type = "cast_success", trigger_groups=6}, -- Grounding Totem
  [16188] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Nature's Swiftness
  [20608] = {durations = {2400}, event_type = "cast_success", trigger_groups=6}, -- Reincarnation
  [30823] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Shamanistic Rage
  [25525] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Stoneclaw Totem
  [2484] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Earthbind Totem
  [16166] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Elemental Mastery
  -- Warlock
  [29858] = {durations = {300}, event_type = "cast_success", trigger_groups=6}, -- Soulshatter
  [30912] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Conflagrate
  [30545] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Soulfire
  [27277] = {durations = {8}, event_type = "cast_success", trigger_groups=6}, -- Devour Magic
  [18708] = {durations = {900}, event_type = "cast_success", trigger_groups=6}, -- Fel Domination
  [28610] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Shadow Ward
  [30910] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Curse of Doom
  [33703] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Suffering
  [18288] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Amplify Curse
  [27223] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Death Coil
  [17928] = {durations = {40}, event_type = "cast_success", trigger_groups=6}, -- Howl of Terror
  [19647] = {durations = {24}, event_type = "cast_success", trigger_groups=6}, -- Spell Lock
  [30546] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Shadowburn
  [30414] = {durations = {20}, event_type = "cast_success", trigger_groups=6}, -- Shadowfury
  [27275] = {durations = {4}, event_type = "cast_success", trigger_groups=6}, -- Soothing Kiss
  -- Warrior
  [1161] = {durations = {420}, event_type = "cast_success", trigger_groups=6}, -- Challenging Shout
  [1719] = {durations = {1200}, event_type = "cast_success", trigger_groups=6}, -- Recklessness
  [2565] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Shield Block
  [5246] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Intimidating Shout
  [11585] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Overpower
  [2687] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Bloodrage
  [12328] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Sweeping Strikes
  [25275] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Intercept
  [12809] = {durations = {45}, event_type = "cast_success", trigger_groups=6}, -- Concussion Blow
  [20230] = {durations = {1200}, event_type = "cast_success", trigger_groups=6}, -- Retaliation
  [11578] = {durations = {15}, event_type = "cast_success", trigger_groups=6}, -- Charge
  [676] = {durations = {60}, event_type = "cast_success", trigger_groups=6}, -- Disarm
  [25266] = {durations = {120}, event_type = "cast_success", trigger_groups=6}, -- Mocking Blow
  [30357] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Revenge
  [30330] = {durations = {5}, event_type = "cast_success", trigger_groups=6}, -- Mortal Strike
  [29704] = {durations = {12}, event_type = "cast_success", trigger_groups=6}, -- Shield Bash
  [23920] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Spell Reflection
  [871] = {durations = {1200}, event_type = "cast_success", trigger_groups=6}, -- Shield Wall
  [3411] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Intervene
  [1680] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Whirlwind
  [6554] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Pummel
  [30356] = {durations = {6}, event_type = "cast_success", trigger_groups=6}, -- Shield Slam
  [12975] = {durations = {480}, event_type = "cast_success", trigger_groups=6}, -- Last Stand
  [18499] = {durations = {30}, event_type = "cast_success", trigger_groups=6}, -- Berserker Rage
  [30335] = {durations = {6}, event_type = "cast_success", trigger_groups=6}, -- Bloodthirst
  [355] = {durations = {10}, event_type = "cast_success", trigger_groups=6}, -- Taunt
  [25264] = {durations = {4}, event_type = "cast_success", trigger_groups=6}, -- Thunderclap
  [12292] = {durations = {180}, event_type = "cast_success", trigger_groups=6}, -- Death Wish
}

addonTable.swing_spells = {}
