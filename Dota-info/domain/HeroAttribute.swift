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

}