local addonName, addonTable = ...

if (not WOW_PROJECT_BURNING_CRUSADE_CLASSIC == 5) then return end

-- a quick guide to the variable "trigger_groups"
-- when a spell is in the list, if it is cast, it will always be evaluated
-- the "who" variable decides whether or not the addon user WANTS the variable to BE evaluated for a particular target type (party, self, hostile)
-- it does that through a bit operation. 1 for self, 2 for party, 4 for hostile. u can add those numbers depending on which types u want the spell to be tracked for.

addonTable.spells_list = {
  --[11285] = {durations = {5}, event_type = "cast_success", who=7, spells_that_also_go_on_cooldown = { {id = 20473, durations = 7.6}}}, -- DEV_ITEM
  -- Rogue
  [14185] = {durations = {600}, event_type = "cast_success", trigger_groups=7, spells_that_are_removed_from_cooldown={14177, 36554, 11305, 26889, 14183, 26669}}, -- Preparation
  [38764] = {durations = {9}, event_type = "cast_success", trigger_groups=7}, -- Gouge
  [38768] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Kick
  [1725] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Distract
  [27448] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Feint
  [8643] = {durations = {20}, event_type = "cast_success", trigger_groups=7}, -- Kidney Shot
  [36554] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Shadowstep
  [11305] = {durations = {300, 210, 300}, event_type = "cast_success", trigger_groups=7}, -- Sprint
  [1787] = {durations = {5, 10, 5}, event_type = "cooldown_on_remove", trigger_groups=7}, -- Stealth
  [26889] = {durations = {210, 300, 210}, event_type = "cast_success", trigger_groups=7}, -- Vanish
  [14251] = {durations = {6}, event_type = "cast_success", trigger_groups=7}, -- Riposte
  [13877] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Blade Flurry
  [14278] = {durations = {20}, event_type = "cast_success", trigger_groups=7}, -- Ghostly Strike
  [2094] = {durations = {90, 180, 90}, event_type = "cast_success", trigger_groups=7}, -- Blind
  [14183] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Premeditation
  [26669] = {durations = {300, 210, 300}, event_type = "cast_success", trigger_groups=7}, -- Evasion
  [14177] = {durations = {180}, event_type = "cooldown_on_remove", trigger_groups=7}, -- Cold Blood
  [31224] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Cloak of Shadows
  [13750] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Adrenaline Rush
  -- Druid
  [9913] = {durations = {10}, event_type = "cooldown_on_remove", trigger_groups=7}, -- Prowl
  [26999] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Frenzied Regeneration
  [8983] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Bash
  [5209] = {durations = {600}, event_type = "cast_success", trigger_groups=7}, -- Challenging Roar
  [27048] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Cower
  [33357] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Dash
  [5229] = {durations = {60}, event_type = "cast_success", trigger_groups=1}, -- Enrage
  [33831] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Force of Nature
  [33987] = {durations = {6}, event_type = "cast_success", trigger_groups=7}, -- Mangle (Bear)
  [16979] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Feral Charge
  [6795] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Growl
  [18562] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Swiftmend
  [17402] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Hurricane
  [27011] = {durations = {6}, event_type = "cast_success", trigger_groups=7}, -- Faerie Fire (Feral)
  [29166] = {durations = {360}, event_type = "cast_success", trigger_groups=7}, -- Innervate
  [27009] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Nature's Grasp
  [17116] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Nature's Swiftness
  [26994] = {durations = {1200}, event_type = "cast_success", trigger_groups=7}, -- Rebirth
  [22812] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Barkskin
  [9862] = {durations = {600}, event_type = "cast_success", trigger_groups=7}, -- Tranquility
  -- Hunter
  [14327] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Scare Beast
  [19574] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Bestial Wrath
  [19503] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Scatter Shot
  [27018] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Viper Sting
  [34026] = {durations = {5}, event_type = "cast_success", trigger_groups=7}, -- Kill Command
  [34477] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Misdirection
  [27685] = {durations = {25}, event_type = "cast_success", trigger_groups=7}, -- Charge
  [23989] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Readiness
  [3045] = {durations = {300, 180, 300}, event_type = "cast_success", trigger_groups=7}, -- Rapid Fire
  [34600] = {durations = {24}, event_type = "cast_success", trigger_groups=7, spells_that_also_go_on_cooldown={{id = 27023, durations = 24},{id = 27025, durations = 24},{id = 14311, durations = 24},{id = 13809, durations = 24},}}, -- Snake Trap
  [27023] = {durations = {24}, event_type = "cast_success", trigger_groups=7, spells_that_also_go_on_cooldown={{id = 34600, durations = 24},{id = 27025, durations = 24},{id = 14311, durations = 24},{id = 13809, durations = 24},}}, -- Immolation Trap
  [27025] = {durations = {24}, event_type = "cast_success", trigger_groups=7, spells_that_also_go_on_cooldown={{id = 27023, durations = 24},{id = 34600, durations = 24},{id = 13809, durations = 24},{id = 14311, durations = 24},}}, -- Explosive Trap
  [14311] = {durations = {24}, event_type = "cast_success", trigger_groups=7, spells_that_also_go_on_cooldown={{id = 27023, durations = 24},{id = 34600, durations = 24},{id = 27025, durations = 24},{id = 13809, durations = 24},}}, -- Freezing Trap
  [13809] = {durations = {24}, event_type = "cast_success", trigger_groups=7, spells_that_also_go_on_cooldown={{id = 27023, durations = 24},{id = 34600, durations = 24},{id = 27025, durations = 24},{id = 14311, durations = 24},}}, -- Frost Trap
  [27022] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Volley
  [5384] = {durations = {30}, event_type = "cooldown_on_remove", trigger_groups=7}, -- Feign Death
  [34490] = {durations = {20}, event_type = "cast_success", trigger_groups=7}, -- Silencing Shot
  [27067] = {durations = {5}, event_type = "cast_success", trigger_groups=7}, -- Counterattack
  [19263] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Deterrence
  [27068] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Wyvern Sting
  [27065] = {durations = {6}, event_type = "spell_damage", trigger_groups=7}, -- Aimed Shot
  [1543] = {durations = {20}, event_type = "cast_success", trigger_groups=7}, -- Flare
  [5116] = {durations = {11}, event_type = "cast_success", trigger_groups=7}, -- Concussive Shot
  [19801] = {durations = {20}, event_type = "cast_success", trigger_groups=7}, -- Tranquilizing Shot
  -- Mage
  [66] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Invisibility
  [33043] = {durations = {20}, event_type = "cast_success", trigger_groups=7}, -- Dragon's Breath
  [1953] = {durations = {13}, event_type = "cast_success", trigger_groups=7}, -- Blink
  [27128] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Fireward
  [11129] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Combustion
  [12472] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Icy Veins
  [45438] = {durations = {300, 300, 240}, event_type = "cast_success", trigger_groups=7}, -- Ice block
  [27088] = {durations = {25, 25, 21}, event_type = "cast_success", trigger_groups=7}, -- Frost Nova
  [32796] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Frost Ward
  [27087] = {durations = {10, 10, 8}, event_type = "cast_success", trigger_groups=7}, -- Cone of Cold
  [2139] = {durations = {24}, event_type = "cast_success", trigger_groups=7}, -- Counterspell
  [31687] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Summon Water Elemental
  [11958] = {durations = {480, 480, 384}, event_type = "cast_success", trigger_groups=7, spells_that_are_removed_from_cooldown={27087, 32796, 27088, 45438, 12472, 31687, 33405}}, -- Cold Snap
  [33405] = {durations = {30, 30, 24}, event_type = "cast_success", trigger_groups=7}, -- Ice Barrier
  [33933] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Blast Wave
  [12043] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Presence of Mind
  [12042] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Arcane Power
  [12051] = {durations = {480}, event_type = "cast_success", trigger_groups=7}, -- Evocation
  -- Paladin
  [27180] = {durations = {6}, event_type = "cast_success", trigger_groups=7}, -- Hammer of Wrath
  [31789] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Righteous Defense
  [32700] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Avenger's Shield
  [31884] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Avenging Wrath
  [27179] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Holy Shield
  [35395] = {durations = {6}, event_type = "cast_success", trigger_groups=7}, -- Crusader Strike
  [31842] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Divine Illumination
  [1020] = {durations = {300, 240, 300}, event_type = "cast_success", trigger_groups=7}, -- Divine Shield
  [27139] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Holy Wrath SPELL_CAST_START
  [27138] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Exorcism
  [20216] = {durations = {120}, event_type = "cooldown_on_remove", trigger_groups=7}, -- Divine Favor
  [27173] = {durations = {8}, event_type = "cast_success", trigger_groups=7}, -- Consecration
  [27154] = {durations = {2400}, event_type = "cast_success", trigger_groups=7}, -- Lay on Hands
  [20066] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Repentance
  [5573] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Divine Protection
  [20271] = {durations = {10, 8, 8}, event_type = "cast_success", trigger_groups=7}, -- Judgement
  [10308] = {durations = {45, 45, 45}, event_type = "cast_success", trigger_groups=7}, -- Hammer of Justice
  [10278] = {durations = {180, 180, 180}, event_type = "cast_success", trigger_groups=7}, -- Blessing of Protection
  [27148] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Blessing of Sacrifice
  [1044] = {durations = {25}, event_type = "cast_success", trigger_groups=7}, -- Blessing of Freedom
  [33072] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Holy Shock
  [10326] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Turn Evil
  [5627] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Turn Undead
  -- Priest
  [25446] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Starshards
  [32676] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Consume Magic
  [14751] = {durations = {180}, event_type = "cooldown_on_remove", trigger_groups=7}, -- Inner Focus
  [44046] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Chastise
  [2651] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Elune's Grace
  [6346] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Fear Ward
  [33206] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Pain Suppression
  [10060] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Power Infusion
  [25218] = {durations = {4}, event_type = "cast_success", trigger_groups=7}, -- Power Word: Shield
  [33076] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Prayer of Mending
  [25437] = {durations = {600}, event_type = "cast_success", trigger_groups=7}, -- Desperate Prayer
  [28275] = {durations = {360}, event_type = "cast_success", trigger_groups=7}, -- Lightwell
  [32548] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Symbol of Hope
  [25429] = {durations = {30, 30, 24}, event_type = "cast_success", trigger_groups=7}, -- Fade
  [25467] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Devouring Plague
  [32996] = {durations = {12}, event_type = "cast_success", trigger_groups=7}, -- Shadow Word: Death
  [15487] = {durations = {45}, event_type = "cast_success", trigger_groups=7}, -- Silence
  [10890] = {durations = {30, 30, 26}, event_type = "cast_success", trigger_groups=7}, -- Psychic Scream
  [25441] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Feedback
  [34433] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Shadowfiend
  [15286] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Vampiric Embrace
  -- Shaman
  [32182] = {durations = {600}, event_type = "cast_success", trigger_groups=7}, -- Heroism
  [17364] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Stormstrike
  [25547] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Fire Nova Totem
  [16190] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Mana Tide Totem
  [2825] = {durations = {600}, event_type = "cast_success", trigger_groups=7}, -- Bloodlust
  [2062] = {durations = {2400}, event_type = "cast_success", trigger_groups=7}, -- Earth Elemental Totem
  [25454] = {durations = {5, 5, 6}, event_type = "cast_success", trigger_groups=7}, -- Earth Shock
  [8177] = {durations = {13, 13, 13}, event_type = "cast_success", trigger_groups=7}, -- Grounding Totem
  [16188] = {durations = {180}, event_type = "cooldown_on_remove", trigger_groups=7}, -- Nature's Swiftness
  [20608] = {durations = {2400}, event_type = "cast_success", trigger_groups=7}, -- Reincarnation
  [30823] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Shamanistic Rage
  [25525] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Stoneclaw Totem
  [2484] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Earthbind Totem
  [16166] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Elemental Mastery
  -- Warlock
  [29858] = {durations = {300}, event_type = "cast_success", trigger_groups=7}, -- Soulshatter
  [30912] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Conflagrate
  [30545] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Soulfire
  [27277] = {durations = {8}, event_type = "cast_success", trigger_groups=7}, -- Devour Magic
  [18708] = {durations = {900}, event_type = "cast_success", trigger_groups=7}, -- Fel Domination
  [28610] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Shadow Ward
  [30910] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Curse of Doom
  [33703] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Suffering
  [18288] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Amplify Curse
  [27223] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Death Coil
  [17928] = {durations = {40}, event_type = "cast_success", trigger_groups=7}, -- Howl of Terror
  [19647] = {durations = {24}, event_type = "cast_success", trigger_groups=7}, -- Spell Lock
  [30546] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Shadowburn
  [30414] = {durations = {20}, event_type = "cast_success", trigger_groups=7}, -- Shadowfury
  [27275] = {durations = {4}, event_type = "cast_success", trigger_groups=7}, -- Soothing Kiss
  -- Warrior
  [1161] = {durations = {420}, event_type = "cast_success", trigger_groups=7}, -- Challenging Shout
  [1719] = {durations = {1200, 1800, 1800}, event_type = "cast_success", trigger_groups=7}, -- Recklessness
  [2565] = {durations = {5}, event_type = "cast_success", trigger_groups=7}, -- Shield Block
  [5246] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Intimidating Shout
  [2687] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Bloodrage
  [12328] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Sweeping Strikes
  [25275] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Intercept
  [676] = {durations = {60}, event_type = "cast_success", trigger_groups=7}, -- Disarm
  [29704] = {durations = {12}, event_type = "spell_damage", trigger_groups=7}, -- Shield Bash
  [23920] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Spell Reflection
  [871] = {durations = {1200, 1800, 1800}, event_type = "cast_success", trigger_groups=7}, -- Shield Wall
  [3411] = {durations = {20, 30, 30}, event_type = "cast_success", trigger_groups=7}, -- Intervene
  [6554] = {durations = {10}, event_type = "cast_success", trigger_groups=7}, -- Pummel
  [18499] = {durations = {30}, event_type = "cast_success", trigger_groups=7}, -- Berserker Rage
  [355] = {durations = {10, 10, 8}, event_type = "cast_success", trigger_groups=7}, -- Taunt
  [11578] = {durations = {15}, event_type = "cast_success", trigger_groups=7}, -- Charge
  [25264] = {durations = {4}, event_type = "cast_success", trigger_groups=7}, -- Thunderclap
  [12292] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Death Wish
  [30356] = {durations = {6}, event_type = "cast_success", trigger_groups=7}, -- Shield Slam 
  [12975] = {durations = {480}, event_type = "cast_success", trigger_groups=7}, -- Last Stand
  [30357] = {durations = {5}, event_type = "cast_success", trigger_groups=7}, -- Revenge
  [30330] = {durations = {5}, event_type = "cast_success", trigger_groups=7}, -- Mortal Strike
  [12809] = {durations = {45}, event_type = "cast_success", trigger_groups=7}, -- Concussion Blow
  [20230] = {durations = {1200, 1800, 1800}, event_type = "cast_success", trigger_groups=7}, -- Retaliation
  [25266] = {durations = {120}, event_type = "cast_success", trigger_groups=7}, -- Mocking Blow
  [11585] = {durations = {5}, event_type = "cast_success", trigger_groups=7}, -- Overpower
  -- Human
  [20600] = {durations = {180}, event_type = "cast_success", trigger_groups=7}, -- Perception
}

addonTable.swing_spells = {}

addonTable.special_spells_list = {
  -- Druid
  [24858] = 1, -- Moonkin, Moonkin Form
  [33831] = 1, -- Moonkin, Force of Nature
  [24932] = 2, -- Feral, Leader of the Pack
  [33987] = 2, -- Feral, Mangle(Bear)
  [33983] = 2, -- Feral, Mangle(Cat)
  [18562] = 3, -- Resto, Swiftmend
  [33891] = 3, -- Resto, Tree of Life
  -- Hunter
  [19574] = 1, -- BM, Bestial Wrath
  [27066] = 2, -- MM, Trueshot Aura
  [34490] = 2, -- MM, Silencing Shot
  [27068] = 3, -- SV, Wyvern Sting
  [23989] = 3, -- SV, Readiness
  -- Mage
  [12042] = 1, -- Arcane, Arcane Power
  [31589] = 1, -- Arcane, Slow
  [11129] = 2, -- Fire, Combustion
  [33043] = 2, -- Fire, Dragon's Fire
  [33405] = 3, -- Frost, Ice Barrier
  [31687] = 3, -- Frost, Summon Water Elemental
  -- Paladin
  [33072] = 1, -- Holy, Holy Shock
  [31842] = 1, -- Holy, Divine Illumination
  [27179] = 2, -- Prot, Holy Shield
  [32700] = 2, -- Prot, Avenger's Shield
  [20066] = 3, -- Ret, Repentance
  [35395] = 3, -- Ret, Crusader Strike
  -- Priest
  [10060] = 1, -- Disc, Power Infusion
  [33206] = 1, -- Disc, Pain Suppression
  [28275] = 2, -- Holy, Lightwell
  [34866] = 2, -- Holy, Circle of Healing
  [15473] = 3, -- Shadow, Shadowform
  [34917] = 3, -- Shadow, Vampiric Touch
  -- Rogue
  [34413] = 1, -- Ass, Mutilate
  [13750] = 2, -- Combat, Adrenaline Rush
  [13877] = 2, -- Combat, Blade Flurry
  [14183] = 3, -- Sub, Premeditation
  [36554] = 3, -- Sub, Shadowstep
  -- Shaman
  [16166] = 1, -- Ele, Elemental Mastery
  [30706] = 1, -- Ele, Elemental Mastery
  [17364] = 2, -- Enha, Stormstrike
  [30823] = 2, -- Enha, Shamanistic Rage
  [16190] = 3, -- Resto, Mana Tide Totem
  [32594] = 3, -- Resto, Earth Shield
  -- Warlock
  [27265] = 1, -- Affli, Dark Pact
  [30405] = 1, -- Affli, Unstable Affliction
  [19028] = 2, -- Demo, Soul Link
  [30146] = 2, -- Demo, Summon Felguard
  [30912] = 3, -- Destro, Conflagrate
  [30414] = 3, -- Destro, Shadowfury
  -- Warrior
  [30330] = 1, -- Arms, Mortal Strike
  [30335] = 2, -- Fury, Bloodthirst
  [30033] = 2, -- Fury, Rampage
  [30356] = 3, -- Prot, Shield Slam
  [30022] = 3, -- Prot, Devastate
}
