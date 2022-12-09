//
//  viewModelDevelopers.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 9/12/22.
//

import Foundation
import Combine

final class viewModelDevelopers: ObservableObject {
    //Variable para guardar las variables
    @Published var developers: [Developer]?
    @Published var status = Status.none
    
    
    //Creo suscriptor
    var suscriptors = Set<AnyCancellable>()
    
    //INIT
    public init(testing: Bool = false, boot: [Bootcamp]=[]) {
        if testing {
            getDeveloperDesing(boot: boot)
        } else {
            getDevelopers()
        }
    }
    
    //MARK: FUNCION GET DEVELOPERS EN RED
    func getDevelopers() {
        self.status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionDevelopers())
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                //All is OK
                return $0.data
            }
            .decode(type: [Developer].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.status = .loaded
                case .failure:
                    self.status = .error(error: "Error en la llamada a developers")
                }
            
            } receiveValue: { data in
                self.developers = data
            }
            .store(in: &suscriptors)
    }
    
    //MARK: FUNCION LE DOY UN BOOTCAMO Y ME ENCUENTRA TODOS LOS DEVELOPERS
    func getDevelopersOfBootcamp(id: String) -> [Developer] {
        return developers!
            .filter {
                $0.bootcamp.id == id
            }
    }
    
    //MARK: FUNCION GET DEVELOPERS DISEÑO
    func getDeveloperDesing(boot: [Bootcamp]) {
        //ME CREO EL BOOTCAMP
        let b1 = Bootcamp(id: boot[0].id, name: boot[0].name)
        let b2 = Bootcamp(id: boot[1].id, name: boot[1].name)
        //ME CREO EL DEVELOPER
        let dev1 = Developer(bootcamp: b1, id: "100", apell1: "Iglesias", apell2: "Pubill", email: "", name: "Aitor", photo: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", heros: [])
        
        let dev2 = Developer(bootcamp: b1, id: "200", apell1: "Aguirre", apell2: "Lopez", email: "", name: "Antonio", photo: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", heros: [])
        
        let dev3 = Developer(bootcamp: b2, id: "300", apell1: "Manzano", apell2: "Hurtado", email: "", name: "Paco", photo: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", heros: [])
        
        let dev4 = Developer(bootcamp: b2, id: "400", apell1: "Rodriguez", apell2: "Santano", email: "", name: "Ismael", photo: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", heros: [])
        
        self.developers = [dev1, dev2, dev3, dev4]
    }
    
}
