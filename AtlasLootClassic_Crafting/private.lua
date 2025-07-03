local addonname, private = ...
local AtlasLoot = _G.AtlasLoot

private.ALCHEMY_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Alchemy",
    [AtlasLoot.BC_VERSION_NUM]          = "AlchemyBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "AlchemyWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "AlchemyCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "AlchemyMoP",
}

private.BLACKSMITHING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Blacksmithing",
    [AtlasLoot.BC_VERSION_NUM]          = "BlacksmithingBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "BlacksmithingWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "BlacksmithingCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "BlacksmithingMoP",
}

private.ENCHANTING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Enchanting",
    [AtlasLoot.BC_VERSION_NUM]          = "EnchantingBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "EnchantingWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "EnchantingCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "EnchantingMoP",
}

private.ENGINEERING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Engineering",
    [AtlasLoot.BC_VERSION_NUM]          = "EngineeringBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "EngineeringWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "EngineeringCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "EngineeringMoP",
}

private.TAILORING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Tailoring",
    [AtlasLoot.BC_VERSION_NUM]          = "TailoringBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "TailoringWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "TailoringCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "TailoringMoP",
}

private.LEATHERWORKING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Leatherworking",
    [AtlasLoot.BC_VERSION_NUM]          = "LeatherworkingBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "LeatherworkingWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "LeatherworkingCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "LeatherworkingMoP",
}

private.JEWELCRAFTING_LINK = {
    [AtlasLoot.BC_VERSION_NUM]          = "JewelcraftingBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "JewelcraftingWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "JewelcraftingCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "JewelcraftingMoP",
}

private.MINING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Mining",
    [AtlasLoot.BC_VERSION_NUM]          = "MiningBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "MiningWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "MiningCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "MiningMoP",

}

private.HERBALISM_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Herbalism",
    [AtlasLoot.BC_VERSION_NUM]          = "HerbalismBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "HerbalismWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "HerbalismCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "HerbalismMoP",
}

private.SKINNING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Skinning",
    [AtlasLoot.BC_VERSION_NUM]          = "SkinningBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "SkinningWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "SkinningCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "SkinningMoP",
}

private.COOKING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Cooking",
    [AtlasLoot.BC_VERSION_NUM]          = "CookingBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "CookingWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "CookingCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "CookingMoP",
}

private.FIRSTAID_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "FirstAid",
    [AtlasLoot.BC_VERSION_NUM]          = "FirstAidBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "FirstAidWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "FirstAidCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "FirstAidMoP",
}

private.FISHING_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "Fishing",
    [AtlasLoot.BC_VERSION_NUM]          = "FishingBC",
    [AtlasLoot.WRATH_VERSION_NUM]       = "FishingWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "FishingCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "FishingMoP",
}

private.ROGUE_POISONS_LINK = {
    [AtlasLoot.CLASSIC_VERSION_NUM]     = "RoguePoisons",
    [AtlasLoot.BC_VERSION_NUM]          = "RoguePoisonsBC",
}

private.INSCRIPTION_LINK = {
    [AtlasLoot.WRATH_VERSION_NUM]       = "InscriptionWrath",
    [AtlasLoot.CATA_VERSION_NUM]        = "InscriptionCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "InscriptionMoP",
}

private.ARCHAEOLOGY_LINK = {
    [AtlasLoot.CATA_VERSION_NUM]       = "ArchaeologyCata",
    [AtlasLoot.MOP_VERSION_NUM]         = "ArchaeologyMoP",
}