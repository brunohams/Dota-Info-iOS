import Foundation
import RxSwift

class GetHeroes {

    var heroService: HeroService

    init (heroService: HeroService) {
        self.heroService = heroService
    }

    func execute() -> Observable<DataState<[Hero]>> {
        return Observable<DataState<[Hero]>>.create { [weak self] observer in
            DispatchQueue.global(qos: .background).async( execute: {

                let listOfHeroes = [
                        Hero(id: 1, localizedName: "teste", primaryAtribute: HeroAttribute.agility(HeroAttribute.Agility()), attackType: HeroAttackType.melee(HeroAttackType.Melee()), role: [HeroRole.carry(HeroRole.Carry())], img: "test", icon: "test", baseHealth: 0, baseHealthRegen: 0, baseMana: 0, baseManaRegen: 0, baseArmor: 0, baseMoveRate: 0, baseAttackMin: 0, baseAttackMax: 0, baseStr: 0, baseAgi: 0, baseInt: 0, strGain: 0, agiGain: 0, intGain: 0, attackRange: 0, projectileSpeed: 0, attackRate: 0, moveSpeed: 0, legs: 0, turboPicks: 0, turboWins: 0, firstPick: 0, firstWin: 0, secondPick: 0, secondWin: 0, thirdPick: 0, thirdWin: 0, fourthPick: 0, fourthWin: 0, fifthPick: 0, fifthWin: 0, sixthPick: 0, sixthWin: 0, seventhPick: 0, seventhWin: 0, eighthPick: 0, eighthWin: 0)
                ]

                let dataStateLoading = DataState<[Hero]>.loading(progressState: ProgressState.loading)
                observer.on(.next(dataStateLoading))

                sleep(1)

                let dataStateErrorDialog = DataState<[Hero]>.response(uiComponent: UIComponent.Dialog(title: "Erro titulo", description: "erro descricao"))
                let dataStateErrorLog = DataState<[Hero]>.response(uiComponent: UIComponent.None(message: "Log error"))
                let dataStateData = DataState<[Hero]>.data(data: listOfHeroes)
                let dataStateIdle = DataState<[Hero]>.loading(progressState: ProgressState.idle)

                observer.on(.next(dataStateErrorDialog))
                observer.on(.next(dataStateData))

                sleep(1)

                observer.on(.next(dataStateIdle))

                observer.on(.next(dataStateErrorLog))

                observer.onCompleted()
            })

            return Disposables.create()

        }.observeOn(SerialDispatchQueueScheduler(qos: .background))
    }

}