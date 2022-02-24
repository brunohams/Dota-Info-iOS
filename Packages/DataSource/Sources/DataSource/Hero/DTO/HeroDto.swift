import Foundation
@testable import Domain

struct HeroDto: Codable {
    let id: Int
    let name, localizedName: String
    let primaryAttr: String
    let attackType: String
    let roles: [String]
    let img, icon: String
    let baseHealth: Float
    let baseHealthRegen: Float
    let baseMana: Float
    let baseManaRegen, baseArmor: Float
    let baseMr, baseAttackMin, baseAttackMax, baseStr: Int
    let baseAgi, baseInt: Int
    let strGain, agiGain, intGain: Float
    let attackRange, projectileSpeed: Int
    let attackRate: Float
    let moveSpeed: Int
    let turnRate: Float?
    let cmEnabled: Bool
    let legs, heroID, turboPicks, turboWINS: Int
    let proBan: Int
    let proWin, proPick: Int?
    let the1_Pick, the1_Win, the2_Pick, the2_Win: Int
    let the3_Pick, the3_Win, the4_Pick, the4_Win: Int
    let the5_Pick, the5_Win, the6_Pick, the6_Win: Int
    let the7_Pick, the7_Win, the8_Pick, the8_Win: Int
    let nullPick, nullWin: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles, img, icon
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case projectileSpeed = "projectile_speed"
        case attackRate = "attack_rate"
        case moveSpeed = "move_speed"
        case turnRate = "turn_rate"
        case cmEnabled = "cm_enabled"
        case legs
        case heroID = "hero_id"
        case turboPicks = "turbo_picks"
        case turboWINS = "turbo_wins"
        case proBan = "pro_ban"
        case proWin = "pro_win"
        case proPick = "pro_pick"
        case the1_Pick = "1_pick"
        case the1_Win = "1_win"
        case the2_Pick = "2_pick"
        case the2_Win = "2_win"
        case the3_Pick = "3_pick"
        case the3_Win = "3_win"
        case the4_Pick = "4_pick"
        case the4_Win = "4_win"
        case the5_Pick = "5_pick"
        case the5_Win = "5_win"
        case the6_Pick = "6_pick"
        case the6_Win = "6_win"
        case the7_Pick = "7_pick"
        case the7_Win = "7_win"
        case the8_Pick = "8_pick"
        case the8_Win = "8_win"
        case nullPick = "null_pick"
        case nullWin = "null_win"
    }

    func toHero() -> Hero {
        return Hero(
            id: id,
            localizedName: localizedName,
            primaryAtribute: HeroAttribute.getHeroAttribute(fromValue: primaryAttr),
            attackType: HeroAttackType.getHeroAttackType(fromValue: attackType),
            role: roles.map { role in HeroRole.getHeroRole(fromValue: role) },
            img: img,
            icon: icon,
            baseHealth: baseHealth,
            baseHealthRegen: baseHealthRegen,
            baseMana: baseMana,
            baseManaRegen: baseManaRegen,
            baseArmor: baseArmor,
            baseMoveRate: baseMr,
            baseAttackMin: baseAttackMin,
            baseAttackMax: baseAttackMax,
            baseStr: baseStr,
            baseAgi: baseAgi,
            baseInt: baseInt,
            strGain: strGain,
            agiGain: agiGain,
            intGain: intGain,
            attackRange: attackRange,
            projectileSpeed: projectileSpeed,
            attackRate: attackRange,
            moveSpeed: moveSpeed,
            legs: legs,
            turboPicks: turboPicks,
            turboWins: turboWINS,
            firstPick: the1_Pick,
            firstWin: the1_Win,
            secondPick: the2_Pick,
            secondWin: the1_Win,
            thirdPick: the3_Pick,
            thirdWin: the3_Win,
            fourthPick: the4_Pick,
            fourthWin: the4_Win,
            fifthPick: the5_Pick,
            fifthWin: the5_Win,
            sixthPick: the6_Pick,
            sixthWin: the6_Win,
            seventhPick: the7_Pick,
            seventhWin: the7_Win,
            eighthPick: the8_Pick,
            eighthWin: the8_Win
        )
    }

}

