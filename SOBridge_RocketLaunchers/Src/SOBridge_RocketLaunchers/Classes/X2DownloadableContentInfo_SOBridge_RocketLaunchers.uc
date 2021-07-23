class X2DownloadableContentInfo_SOBridge_RocketLaunchers extends X2DownloadableContentInfo;

var config(WeaponTuning) StrategyRequirement RocketT2_Requirements;
var config(WeaponTuning) StrategyCost RocketT2_NormalCost;
var config(WeaponTuning) StrategyCost RocketT2_LegendCost;

var config(WeaponTuning) StrategyRequirement RocketT3_Requirements;
var config(WeaponTuning) StrategyCost RocketT3_NormalCost;
var config(WeaponTuning) StrategyCost RocketT3_LegendCost;

static event OnPostTemplatesCreated()
{
    local array<X2DataTemplate> DifficultyVariants;
    local X2ItemTemplateManager ItemTemplateManager;    
    local X2WeaponTemplate WeaponTemplate;
    local X2DataTemplate DataTemplate;
    
    ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

    ItemTemplateManager.FindDataTemplateAllDifficulties('IRI_X2Rocket_Plasma', DifficultyVariants);
    foreach DifficultyVariants(DataTemplate)
    {
        WeaponTemplate = X2WeaponTemplate(DataTemplate);

        if (WeaponTemplate != none)
        {
            WeaponTemplate.Requirements = default.RocketT2_Requirements;
			if (GetTemplateDifficulty(WeaponTemplate) == 3) {
				WeaponTemplate.Cost = default.RocketT2_LegendCost;
			} else {
				WeaponTemplate.Cost = default.RocketT2_NormalCost;
			}
        }
    }

    ItemTemplateManager.FindDataTemplateAllDifficulties('IRI_X2Rocket_Elerium', DifficultyVariants);
    foreach DifficultyVariants(DataTemplate)
    {
        WeaponTemplate = X2WeaponTemplate(DataTemplate);

        if (WeaponTemplate != none)
        {
            WeaponTemplate.Requirements = default.RocketT3_Requirements;
			if (GetTemplateDifficulty(WeaponTemplate) == 3) {
				WeaponTemplate.Cost = default.RocketT3_LegendCost;
			} else {
				WeaponTemplate.Cost = default.RocketT3_NormalCost;
			}
        }
    }
}

// Helper function copied from Prototype Armoury
static function int GetTemplateDifficulty (X2ItemTemplate ItemTemplate)
{
	if (ItemTemplate.IsTemplateAvailableToAllAreas(class'X2DataTemplate'.const.BITFIELD_GAMEAREA_Rookie))
	{
		return 0; // Rookie
	}
	else if (ItemTemplate.IsTemplateAvailableToAllAreas(class'X2DataTemplate'.const.BITFIELD_GAMEAREA_Veteran))
	{
		return 1; // Veteran
	}
	else if (ItemTemplate.IsTemplateAvailableToAllAreas(class'X2DataTemplate'.const.BITFIELD_GAMEAREA_Commander))
	{
		return 2; // Commander
	}
	else if (ItemTemplate.IsTemplateAvailableToAllAreas(class'X2DataTemplate'.const.BITFIELD_GAMEAREA_Legend))
	{
		return 3; // Legend
	}
	else
	{
		return -1; // Untranslatable Bitfield
	}
}
