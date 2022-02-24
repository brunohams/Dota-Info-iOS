import Foundation

enum HeroAttackType {

    struct Melee {
        let uiValue = "Melee"
    }

    struct Ranged {
        let uiValue = "Ranged"
    }

    struct Unknown {
        let uiValue = "Unknown"
    }

    case melee(Melee)
    case ranged(Ranged)
    case unknown(Unknown)

    static func getHeroAttackType(fromValue value: String) -> HeroAttackType {
        switch value {
            case "Melee":
                return HeroAttackType.melee(HeroAttackType.Melee())
            case "Ranged":
                return HeroAttackType.ranged(HeroAttackType.Ranged())
            default:
                return HeroAttackType.unknown(HeroAttackType.Unknown())
        }

    }

}