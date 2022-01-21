import Foundation

protocol HeroService {

    func getHeroStats() throws -> [Hero]

}