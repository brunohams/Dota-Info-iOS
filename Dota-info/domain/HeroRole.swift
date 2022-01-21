import Foundation

enum HeroRole {

    struct Carry {
        let uiValue = "Carry"
    }

    struct Escape {
        let uiValue = "Escape"
    }

    struct Nuker {
        let uiValue = "Nuker"
    }

    struct Initiator {
        let uiValue = "Initiator"
    }

    struct Durable {
        let uiValue = "Durable"
    }

    struct Disabler {
        let uiValue = "Disabler"
    }

    struct Jungler {
        let uiValue = "Jungler"
    }

    struct Support {
        let uiValue = "Support"
    }

    struct Pusher {
        let uiValue = "Pusher"
    }

    struct Unknown {
        let uiValue = "Unknown"
    }

    case carry(Carry)
    case escape(Escape)
    case nuker(Nuker)
    case initiator(Initiator)
    case durable(Durable)
    case disabler(Disabler)
    case jungler(Jungler)
    case support(Support)
    case pusher(Pusher)
    case unknown(Unknown)


    static func getHeroRole(fromValue value: String) -> HeroRole {
        switch (value) {
            case "Carry":
                return HeroRole.carry(HeroRole.Carry())
            case "Escape":
                return HeroRole.escape(HeroRole.Escape())
            case "Nuker":
                return HeroRole.nuker(HeroRole.Nuker())
            case "Initiator":
                return HeroRole.initiator(HeroRole.Initiator())
            case "Durable":
                return HeroRole.durable(HeroRole.Durable())
            case "Disabler":
                return HeroRole.disabler(HeroRole.Disabler())
            case "Jungler":
                return HeroRole.jungler(HeroRole.Jungler())
            case "Support":
                return HeroRole.support(HeroRole.Support())
            case "Pusher":
                return HeroRole.pusher(HeroRole.Pusher())
            default:
                return HeroRole.unknown(HeroRole.Unknown())
        }
    }

}