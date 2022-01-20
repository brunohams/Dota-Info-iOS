import Foundation

class GetHeroes {

    var heroService: HeroService

    init (heroService: HeroService) {
        self.heroService = heroService
    }

    func execute() -> DataState<[Hero]> {
        let listOfHeroes = [Hero]()
//        let dataState = DataState<[Hero]>.loading(loading: ProgressState.idle)
        let dataState = DataState<[Hero]>.response(uiComponent: UIComponent.Dialog(title: "Erro", description: "deu erro"))
//        let dataState = DataState<[Hero]>.data(data: listOfHeroes)

        return dataState
    }

}