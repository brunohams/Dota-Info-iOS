import Foundation
import Alamofire

class HeroServiceImpl: HeroService {

    private let decoder = JSONDecoder()

    func getHeroStats() throws -> [Hero] {
        var heroes: [Hero] = []
        var requestError: Error? = nil
        let request = AF.request(Endpoints.HERO_STATS)

        let group = DispatchGroup()

        group.enter()

        DispatchQueue.global(qos: .default).sync {
            request.responseJSON { response in
                do {
                    if case let .failure(error) = response.result {
                        throw error
                    }
                    guard let data = response.data else { throw NSError(domain: "Data", code: 1) }
                    heroes = try self.decoder.decode([HeroDto].self, from: data).map { heroDto in heroDto.toHero() }
                } catch {
                    // TODO - Improve Error handling
                    print("Error to parse object: \(error)")
                    requestError = error
                }
                group.leave()
            }
        }

        group.wait()

        if let requestError = requestError { throw requestError }

        return heroes

    }

}