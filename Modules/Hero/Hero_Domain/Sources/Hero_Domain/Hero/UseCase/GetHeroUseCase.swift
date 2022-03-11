import Foundation
import RxSwift
@testable import Shared_Domain

class GetHeroUseCase {

    private let heroService: HeroService
    private let logger: Logger
    private let output: GetHeroOutput

    init (heroService: HeroService, loggerFactory: LoggerFactory, output: GetHeroOutput) {
        self.heroService = heroService
        self.logger = loggerFactory.createLogger(tag: "GetHero")
        self.output = output
    }

    func execute() {

        output.didReceive(progress: .loading)
        sleep(2)

        do {
            let hero: Hero = try heroService.getHeroStats()[0]
            output.didReceive(hero: hero)
        } catch {
            logger.log(message: error.localizedDescription)
            let error = ErrorDetail(title: "Erro ao retornar detalhes de heroi", description: error.localizedDescription)
            output.didReceive(error: error)
        }

        output.didReceive(progress: .idle)

    }

    private func createNetworkErrorDialog(for error: Error) -> UIComponent.Dialog {

        return UIComponent.Dialog(
                title: "Erro de rede",
                description: error.localizedDescription
        )

    }

}
