import Foundation
@testable import Domain

protocol HeroService {

    func getHeroStats() throws -> [Hero]

}
