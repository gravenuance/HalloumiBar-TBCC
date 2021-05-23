local addonName, addonTable = ...

local wow_version = select(4, GetBuildInfo())
print(wow_version)
local calc_version_uno = math.floor(wow_version/20000)
local calc_version_dos = wow_version%20000
print(calc_version_uno ~= 1 or calc_version_dos > 10000)
if (calc_version_uno ~= 1 or calc_version_dos > 10000) then return end

-- a quick guide to the variable "who"
-- when a spell is in the list, if it is cast, it will always be evaluated
-- the "who" variable decides whether or not the addon user WANTS the variable to BE evaluated for a particular target type (party, self, hostile)
-- it does that through a bit operation. 1 for self, 2 for party, 4 for hostile. u can add those numbers depending on which types u want the spell to be tracked for.
-- trigger_groups

addonTable.spells_list = {
  --[11286] = {durations = {5}, event_type = "success", who=7, spells_that_also_go_on_cooldown = { {id = 20473, duration = 7.6}}}, -- DEV_ITEM
  -- Rogue
  [14185] = {durations = {600}, event_type = "success", trigger_groups=6, spells_that_are_removed_from_cooldown={1857, 26669, 11305, 14183, 36554}},
  [11285] = {durations = {10}, event_type = "success", trigger_groups=6},
  [1769] = {durations = {10}, event_type = "success", trigger_groups=6},
  [26669] = {durations = {300}, event_type = "success", trigger_groups=6},
  [11305] = {durations = {300}, event_type = "success", trigger_groups=6},
  [8643] = {durations = {20}, event_type = "success", trigger_groups=6},
  [2094] = {durations = {90}, event_type = "success", trigger_groups=6},
  [14183] = {durations = {120}, event_type = "success", trigger_groups=6},
  [36554] = {durations = {30}, event_type = "success", trigger_groups=6},
  [1857] = {durations = {210}, event_type = "success", trigger_groups=6},
  [14177] = {durations = {180}, event_type = "cooldown_on_remove", trigger_groups=6},
}

addonTable.swing_spells = {}
