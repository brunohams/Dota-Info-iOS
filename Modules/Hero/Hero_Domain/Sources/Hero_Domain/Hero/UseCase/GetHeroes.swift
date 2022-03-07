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

    func execute(output: GetHeroesOutput) {
                
        DispatchQueue.global(qos: .background).async( execute: {
            
            output.didGetProgress(progress: .loading)   // Emit LOADING
            sleep(3)
            
            do {
                
                let heroes: [Hero] = try self.heroService.getHeroStats()
                output.didGetHeroes(heroes: heroes) // --> Emit Data
                
            } catch {
                
                self.logger.log(message: error.localizedDescription)

                let errorDialog = self.createNetworkErrorDialog(for: error)
                output.didGetError(uiComponent: errorDialog)  // --> Emit Error
                 
            }

            output.didGetProgress(progress: .idle)  // --> Emit Idle
            
        })
        
    }

    private func createNetworkErrorDialog(for error: Error) -> UIComponent.Dialog {
        
        return UIComponent.Dialog(
            title: "Erro de rede",
            description: error.localizedDescription
        )
        
    }


}
