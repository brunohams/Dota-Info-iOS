import Foundation

enum HeroAttribute {

    struct Agility {
        let uiValue = "Agility"
        let abbreviation = "agi"
    }

    struct Strength {
        let uiValue = "Strength"
        let abbreviation = "str"
    }

    struct Intelligence {
        let uiValue = "Intelligence"
        let abbreviation = "int"
    }

    struct Unknown {
        let uiValue = "Unknown"
        let abbreviation = "unknown"
    }

    case agility(Agility)
    case strength(Strength)
    case intelligence(Intelligence)
    case unknown(Unknown)


    static func getHeroAttribute(fromValue value: String) -> HeroAttribute {
        switch value {
            case "agi":
                return HeroAttribute.agility(HeroAttribute.Agility())
            case "int":
                return HeroAttribute.intelligence(HeroAttribute.Intelligence())
            case "str":
                return HeroAttribute.strength(HeroAttribute.Strength())
            default:
                return HeroAttribute.unknown(HeroAttribute.Unknown())
        }
    }
}

