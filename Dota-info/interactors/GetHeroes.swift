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

                let loading = DataState<[Hero]>.loading(progressState: ProgressState.loading)
                let idle = DataState<[Hero]>.loading(progressState: ProgressState.idle)
                observer.on(.next(loading)) // -> Emit Loading

                do {
                    var heroes: [Hero] = []

                    heroes = try self.heroService.getHeroStats()

                    let dataState = DataState<[Hero]>.data(data: heroes)
                    observer.on(.next(dataState)) // -> Emit Data
                } catch {
                    let errorDialog = UIComponent.Dialog(title: "Erro ao converter dados", description: error.localizedDescription)
                    let dataStateError = DataState<[Hero]>.response(uiComponent: errorDialog)
                    observer.on(.next(dataStateError)) // -> Emit Error
                }

                observer.on(.next(idle)) // -> Emit Idle
                observer.onCompleted()
            }

            return Disposables.create()

        }.observe(on: SerialDispatchQueueScheduler(qos: .background))
    }

}