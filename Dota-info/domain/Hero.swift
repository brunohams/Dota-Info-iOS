import Foundation

struct Hero: Identifiable {
    let id: Int
    let localizedName: String
    let primaryAtribute: HeroAttribute
    let attackType: HeroAttackType
    let role: [HeroRole]
    let img: String
    let icon: String
    let baseHealth: Float
    let baseHealthRegen: Float?
    let baseMana: Float
    let baseManaRegen: Float?
    let baseArmor: Float
    let baseMoveRate: Float
    let baseAttackMin: Int
    let baseAttackMax: Int
    let baseStr: Int
    let baseAgi: Int
    let baseInt: Int
    let strGain: Float // Strength gain per lvl
    let agiGain: Float // Agility gain per lvl
    let intGain: Float // Intelligence gain per lvl
    let attackRange: Int
    let projectileSpeed: Int
    let attackRate: Float
    let moveSpeed: Int
    let turnRate: Float? = 0.0
    let legs: Int // How many legs does this hero have?
    let turboPicks: Int // How many times picked for turbo matches?
    let turboWins: Int // How many times won a turbo match?
    let proWins: Int = 0 // How many times won a pro match?
    let proPick: Int = 0 // How many times picked in pro match?
    let firstPick: Int // How many times picked first?
    let firstWin: Int // How many times picked first and won?
    let secondPick: Int // How many times picked second?
    let secondWin: Int // How many times picked second and won?
    let thirdPick: Int // How many times picked third?
    let thirdWin: Int // How many times picked third and won?
    let fourthPick: Int // How many times picked in fourth round?
    let fourthWin: Int // How many times picked in fourth round and won?
    let fifthPick: Int // How many times picked fifth?
    let fifthWin: Int // How many times picked fifth and won?
    let sixthPick: Int // How many times picked sixth?
    let sixthWin: Int // How many times picked sixth and won?
    let seventhPick: Int // How many times picked seventh?
    let seventhWin: Int // How many times picked seventh and won?
    let eighthPick: Int // How many times picked eighth round?
    let eighthWin: Int // How many times picked eighth and won?
}