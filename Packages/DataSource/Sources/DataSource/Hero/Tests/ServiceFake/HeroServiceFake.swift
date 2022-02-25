import Foundation
@testable import Domain

class HeroServiceFake: HeroService {

    private var responseType: HeroServiceResponseType

    init(responseType: HeroServiceResponseType) {
        self.responseType = responseType
    }

    func getHeroStats() throws -> [Hero] {
        switch responseType {
            case .goodData:
                return try jsonToHeroes(json: HeroDataValid.jsonData)
            case .emptyList:
                return try jsonToHeroes(json: HeroDataEmpty.jsonData)
            case .malformed:
                return try jsonToHeroes(json: HeroDataMalformed.jsonData)
            case .notFound:
                return try jsonToHeroes(json: HeroDataValid.jsonData)
        }
    }

    private func jsonToHeroes(json: String) throws -> [Hero] {
        let decoder = JSONDecoder()
        let data = json.data(using: .utf8)!
        let heroes: [Hero] = try decoder.decode([HeroDto].self, from: data).map { heroDto in heroDto.toHero() }
        return heroes
    }

}
