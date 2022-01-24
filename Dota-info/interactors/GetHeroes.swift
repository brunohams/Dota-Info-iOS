import Foundation
import RxSwift

class GetHeroes {

    var heroService: HeroService

    init (heroService: HeroService) {
        self.heroService = heroService
    }

    func execute() -> Observable<DataState<[Hero]>> {
        return Observable<DataState<[Hero]>>.create { [weak self] observer in
            DispatchQueue.global(qos: .background).async {
                guard let self = self else { return }

                // EMIT LOADING
                observer.on(.next(
                    DataState<[Hero]>.loading(
                        progressState: ProgressState.loading
                    )
                ))

                do {
                    var heroes: [Hero] = try self.heroService.getHeroStats()
                    // EMIT DATA
                    observer.on(.next(
                        DataState<[Hero]>.data(
                            data: heroes
                        )
                    ))
                } catch {
                    // EMIT ERROR
                    observer.on(.next(
                        DataState<[Hero]>.response(
                            uiComponent: UIComponent.Dialog(
                                title: "Erro ao converter dados",
                                description: error.localizedDescription
                            )
                        )
                    ))
                }

                // EMIT IDLE
                observer.on(.next(
                    DataState<[Hero]>.loading(
                        progressState: ProgressState.idle
                    )
                ))

                observer.onCompleted()
            }

            return Disposables.create()

        }.observe(on: SerialDispatchQueueScheduler(qos: .background))
    }

}