import Foundation
import RxSwift

class GetHeroes {

    var heroService: HeroService

    init (heroService: HeroService) {
        self.heroService = heroService
    }

    func execute() -> Observable<DataState<[Hero]>> {
        return Observable<DataState<[Hero]>>.create { observer in
            let listOfHeroes = [Hero]()

            let dataStateLoading = DataState<[Hero]>.loading(progressState: ProgressState.loading)
            observer.on(.next(dataStateLoading))

            sleep(3)

            let dataStateErro = DataState<[Hero]>.response(uiComponent: UIComponent.dialog(uiComponent: UIComponent.Dialog(title: "Erro", description: "deu erro")))
            let dataStateData = DataState<[Hero]>.data(data: listOfHeroes)
            let dataStateIdle = DataState<[Hero]>.loading(progressState: ProgressState.idle)

            observer.on(.next(dataStateErro))
            observer.on(.next(dataStateData))
            observer.on(.next(dataStateIdle))
            sleep(3)
            observer.on(.next(dataStateLoading))

            observer.onCompleted()
            return Disposables.create()
        }
    }

}