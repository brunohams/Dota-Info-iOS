import Foundation
import RxSwift
@testable import Shared_Domain

class GetHeroesUseCase {
    
    private let heroService: HeroService
    private let logger: Logger
    private let output: GetHeroesOutput

    init (heroService: HeroService, loggerFactory: LoggerFactory, output: GetHeroesOutput) {
        self.heroService = heroService
        self.logger = loggerFactory.createLogger(tag: "GetHeroes")
        self.output = output
    }

    func execute() {

        output.didReceive(progress: .loading)

        do {
            let heroes: [Hero] = try heroService.getHeroStats()
            output.didReceive(heroes: heroes)
        } catch {
            logger.log(message: error.localizedDescription)
            let error = ErrorDetail(title: "Erro ao retornar lista de herois.", description: error.localizedDescription)
            output.didReceive(error: error)
        }

        output.didReceive(progress: .idle)

//        let observable = Observable<DataState<[Hero]>>.create { [weak self] observer in
//
//            DispatchQueue.global(qos: .background).async( execute: {
//
//                guard let self = self else { return }
//
//                observer.onNext(DataState<[Hero]>.progress(.loading))  // Emit LOADING
//                sleep(3)
//                do {
//
//                    let heroes: [Hero] = try self.heroService.getHeroStats()
//                    observer.onNext(DataState<[Hero]>.success(heroes))  // --> Emit Data
//
//                } catch {
//
//                    self.logger.log(message: error.localizedDescription)
//
//                    let errorDialog = self.createNetworkErrorDialog(for: error)
//                    observer.onNext(DataState<[Hero]>.error(uiComponent: errorDialog))  // --> Emit Error
//
//                }
//
//                observer.onNext(DataState<[Hero]>.progress(.idle))  // --> Emit Idle
//                observer.onCompleted()
//
//            })
//
//            return Disposables.create()
//
//        }.observe(on: SerialDispatchQueueScheduler(qos: .background))
//
//        output.didReceiveObservable(observable: observable)
        
    }

    private func createNetworkErrorDialog(for error: Error) -> UIComponent.Dialog {
        
        return UIComponent.Dialog(
            title: "Erro de rede",
            description: error.localizedDescription
        )
        
    }


}
