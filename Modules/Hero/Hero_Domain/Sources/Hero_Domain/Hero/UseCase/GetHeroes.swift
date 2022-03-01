import Foundation
import RxSwift
@testable import Shared_Domain

class GetHeroes {
    
    private let heroService: HeroService
    private let logger: Logger

    init (heroService: HeroService, loggerFactory: LoggerFactory) {
        self.heroService = heroService
        self.logger = loggerFactory.createLogger(tag: "GetHeroes")
    }

    func execute() -> Observable<DataState<[Hero]>> {
        
        return Observable<DataState<[Hero]>>.create { [weak self] observer in

            DispatchQueue.global(qos: .background).async( execute: {

                guard let self = self else { return }

                observer.onNext(DataState<[Hero]>.progress(.loading))  // Emit LOADING

                do {
                    
                    let heroes: [Hero] = try self.heroService.getHeroStats()
                    observer.onNext(DataState<[Hero]>.data(heroes))  // --> Emit Data
                    
                } catch {
                    
                    self.logger.log(message: error.localizedDescription)

                    let errorDialog = self.createNetworkErrorDialog(for: error)
                    observer.onNext(DataState<[Hero]>.response(uiComponent: errorDialog))  // --> Emit Error
                    
                }

                observer.onNext(DataState<[Hero]>.progress(.idle))  // --> Emit Idle
                observer.onCompleted()
                
            })

            return Disposables.create()

        }.observe(on: SerialDispatchQueueScheduler(qos: .background))

    }

    private func createNetworkErrorDialog(for error: Error) -> UIComponent.Dialog {
        
        return UIComponent.Dialog(
            title: "Erro de rede",
            description: error.localizedDescription
        )
        
    }


}
