import Foundation
import Combine

class GetHeroes {

    private let heroService: HeroService
    private let logger: Logger
    let subject = PassthroughSubject<DataState<[Hero]>, Never>()

    init (heroService: HeroService, logger: Logger) {
        self.heroService = heroService
        self.logger = logger
    }

    func execute() {
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.001) { // TODO <-- Se livrar dessa gambiarra | Se chamar sem o delay, o primeiro send não esta sendo enviado
            self.subject.send(DataState<[Hero]>.loading(progressState: .loading)) // --> Emit Loading

            do {
                let heroes: [Hero] = try self.heroService.getHeroStats()
                self.subject.send(DataState<[Hero]>.data(data: heroes))  // --> Emit Data
            } catch {
                self.logger.log(message: error.localizedDescription)

                let errorDialog = UIComponent.Dialog(
                        title: "Erro de rede",
                        description: error.localizedDescription
                )
                self.subject.send(DataState<[Hero]>.response(uiComponent: errorDialog))  // --> Emit Error
            }

            self.subject.send(DataState<[Hero]>.loading(progressState: .idle)) // --> Emit Idle
            self.subject.send(completion: .finished)
        }
    }

}