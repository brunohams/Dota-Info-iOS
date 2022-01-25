import Foundation
import Combine

class GetHeroes {

    let heroService: HeroService
    let logger: Logger

    init (heroService: HeroService, logger: Logger) {
        self.heroService = heroService
        self.logger = logger
    }

    func execute() -> AnyPublisher<DataState<[Hero]>, Never> {
        let subject = CurrentValueSubject<DataState<[Hero]>, Never>(
            DataState<[Hero]>.loading(progressState: .loading) // --> Emit Loading
        )

        DispatchQueue.global(qos: .background).async {
            do {
                let heroes: [Hero] = try self.heroService.getHeroStats()
                subject.send(DataState<[Hero]>.data(data: heroes))  // --> Emit Data
            } catch {
                self.logger.log(message: error.localizedDescription)
                let errorDialog = UIComponent.Dialog(
                        title: "Erro de rede",
                        description: error.localizedDescription
                )
                subject.send(DataState<[Hero]>.response(uiComponent: errorDialog))  // --> Emit Error
            }
            subject.send(DataState<[Hero]>.loading(progressState: .idle)) // --> Emit Idle
        }
        return subject.eraseToAnyPublisher()
    }

}