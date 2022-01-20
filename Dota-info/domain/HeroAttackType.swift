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

}