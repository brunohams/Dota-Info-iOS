import Foundation
import RxSwift

class GetHeroes {
    
    private let heroService: HeroService
    private let logger: Logger

    init (heroService: HeroService, loggerFactory: LoggerFactory) {
        self.heroService = heroService
        self.logger = loggerFactory.createLogger(tag: "GetHeroes")
    }

    func execute() -> Observable<DataState<[Hero]>> {
        return Observable.create { observer in
            
            DispatchQueue.global(qos: .background).async {
                observer.on(
                    .next(DataState<[Hero]>.loading(progressState: .loading)) // Emit LOADING
                )
                sleep(3)

                do {
                    let heroes: [Hero] = try self.heroService.getHeroStats()
                    observer.on(
                        .next(DataState<[Hero]>.data(data: heroes)) // --> Emit Data
                    )
                } catch {
                    self.logger.log(message: error.localizedDescription)

                    let errorDialog = UIComponent.Dialog(
                            title: "Erro de rede",
                            description: error.localizedDescription
                    )
                    observer.on(
                        .next(DataState<[Hero]>.response(uiComponent: errorDialog)) // --> Emit Data
                    )
                }

                observer.on(
                    .next(DataState<[Hero]>.loading(progressState: .idle)) // --> Emit Idle
                )
                
                observer.on(.completed)
            }
            
            
            return Disposables.create()
        }
    }

}
