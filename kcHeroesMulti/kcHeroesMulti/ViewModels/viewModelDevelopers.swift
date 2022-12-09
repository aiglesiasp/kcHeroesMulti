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
    public init(testing: Bool = false) {
        if testing {
            getDeveloperDesing()
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
    
    //MARK: FUNCION GET DEVELOPERS DISEÑO
    func getDeveloperDesing() {
        //ME CREO EL BOOTCAMP
        let b1 = Bootcamp(id: UUID().uuidString, name: "Bootcamp Mobile 14")
        let b2 = Bootcamp(id: UUID().uuidString, name: "Bootcamp Mobile 15")
        //ME CREO EL DEVELOPER
        let dev1 = Developer(bootcamp: b1, id: "100", apell1: "Iglesias", apell2: "Pubill", email: "", name: "Aitor", photo: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fes-es%2Fbuscar%2Fpersona%2F&psig=AOvVaw25bhZrsvPH9OU7ZxXKmx1_&ust=1670673229120000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCPjpoPS87PsCFQAAAAAdAAAAABAE", heros: [])
        
        let dev2 = Developer(bootcamp: b1, id: "200", apell1: "Aguirre", apell2: "Lopez", email: "", name: "Antonio", photo: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fes-es%2Fbuscar%2Fpersona%2F&psig=AOvVaw25bhZrsvPH9OU7ZxXKmx1_&ust=1670673229120000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCPjpoPS87PsCFQAAAAAdAAAAABAE", heros: [])
        
        let dev3 = Developer(bootcamp: b2, id: "300", apell1: "Manzano", apell2: "Hurtado", email: "", name: "Paco", photo: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fes-es%2Fbuscar%2Fpersona%2F&psig=AOvVaw25bhZrsvPH9OU7ZxXKmx1_&ust=1670673229120000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCPjpoPS87PsCFQAAAAAdAAAAABAE", heros: [])
        
        let dev4 = Developer(bootcamp: b2, id: "400", apell1: "Rodriguez", apell2: "Santano", email: "", name: "Ismael", photo: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fes-es%2Fbuscar%2Fpersona%2F&psig=AOvVaw25bhZrsvPH9OU7ZxXKmx1_&ust=1670673229120000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCPjpoPS87PsCFQAAAAAdAAAAABAE", heros: [])
        
        self.developers = [dev1, dev2, dev3, dev4]
    }
    
}
