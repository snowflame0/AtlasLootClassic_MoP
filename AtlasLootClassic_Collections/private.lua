local addonname, private = ...
local AtlasLoot = _G.AtlasLoot

private.WORLD_EPICS = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "WorldEpics",
    [AtlasLoot.BC_VERSION_NUM]          = "WorldEpicsBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "WorldEpicsWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "WorldEpicsCata",
    [AtlasLoot.MOP_VERSION_NUM]        =  "WorldEpicsMoP",
}

private.MOUNTS = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Mounts",
    [AtlasLoot.BC_VERSION_NUM]          = "MountsBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "MountsWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "MountsCata",
    [AtlasLoot.MOP_VERSION_NUM]        =  "MountsMoP",
}

private.TABARDS = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Tabards",
    [AtlasLoot.BC_VERSION_NUM]          = "TabardsBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "TabardsWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "TabardsCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "TabardsMoP",
}

private.LEGENDARYS = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Legendarys",
    [AtlasLoot.BC_VERSION_NUM]          = "LegendarysBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "LegendarysWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "LegendarysCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "LegendarysMoP",
}

private.COMPANIONS = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Companions",
    [AtlasLoot.BC_VERSION_NUM]          = "CompanionsBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "CompanionsWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "CompanionsCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "CompanionsMoP",
}

private.COOKING_VENDOR = {
    [AtlasLoot.WRATH_VERSION_NUM]       = "CookingVendorWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "CookingVendorCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "CookingVendorMoP",
}

private.HEIRLOOM = {
    [AtlasLoot.WRATH_VERSION_NUM]       = "HeirloomWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "HeirloomCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "HeirloomMoP",
}

private.VALOR_POINTS = {
    [AtlasLoot.CATA_VERSION_NUM]        = "ValorPointsCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "ValorPointsMoP",
}

private.JUSTICE_POINTS = {
    [AtlasLoot.CATA_VERSION_NUM]        = "JusticePointsCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "JusticePointsMoP",
}

private.SCOURGE_INVASION = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "ScourgeInvasion",
    [AtlasLoot.WRATH_VERSION_NUM]       = "ScourgeInvasionWrath",
}

private.LUNAR_FESTIVAL = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "LunarFestival",
    [AtlasLoot.CATA_VERSION_NUM]        = "LunarFestivalCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "LunarFestivalMoP",
}

private.VALENTINES_DAY = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "ValentinesDay",
    [AtlasLoot.WRATH_VERSION_NUM]       = "ValentinesDayWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "ValentinesDayCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "ValentinesDayMoP",
}

private.NOBLEGARDEN = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Noblegarden",
    [AtlasLoot.CATA_VERSION_NUM]        = "NoblegardenCata",
}

private.CHILDRENS_WEEK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "ChildrensWeek",
    [AtlasLoot.BC_VERSION_NUM]          = "ChildrensWeekBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "ChildrensWeekWrath",
}

private.MIDSUMMER_FESTIVAL = {
    [AtlasLoot.BC_VERSION_NUM]          = "MidsummerFestivalBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "MidsummerFestivalWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "MidsummerFestivalCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "MidsummerFestivalMoP",
}

private.BREWFEST = {
    [AtlasLoot.BC_VERSION_NUM]          = "BrewfestBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "BrewfestWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "BrewfestCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "BrewfestMoP",
}

private.HALLOWEEN = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Halloween",
    [AtlasLoot.BC_VERSION_NUM]          = "HalloweenBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "HalloweenWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "HalloweenCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "HalloweenMoP",
}

private.DAY_OF_THE_DEAD = {
    [AtlasLoot.WRATH_VERSION_NUM]       = "DayoftheDeadWrath",
    [AtlasLoot.MOP_VERSION_NUM]         = "DayoftheDeadMoP",
}

private.WINTER_VEIL = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "WinterVeil",
    [AtlasLoot.CATA_VERSION_NUM]        = "WinterVeilCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "WinterVeilMoP",
}

