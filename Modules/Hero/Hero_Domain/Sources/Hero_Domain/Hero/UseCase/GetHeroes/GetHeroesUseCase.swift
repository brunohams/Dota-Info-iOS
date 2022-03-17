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

        let observable = Observable<DataState<[Hero]>>.create { [self] observer in
            observer.onNext(DataState<[Hero]>.progress(.loading))

            do {
                let heroes: [Hero] = try heroService.getHeroStats()
                observer.onNext(DataState<[Hero]>.success(heroes))
            } catch {
                logger.log(message: error.localizedDescription)
                let error = ErrorDetail(title: "Erro ao retornar lista de herois.", description: error.localizedDescription)

                observer.onNext(DataState<[Hero]>.error(error))
            }

            observer.onNext(DataState<[Hero]>.progress(.idle))
            observer.onCompleted()

            return Disposables.create()
        }

        output.didReceiveObservable(observable: observable)
    }

    private func createNetworkErrorDialog(for error: Error) -> UIComponent.Dialog {
        return UIComponent.Dialog(
            title: "Erro de rede",
            description: error.localizedDescription
        )
    }


}
