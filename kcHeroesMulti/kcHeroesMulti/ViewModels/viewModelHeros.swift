//
//  viewModelheros.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import Foundation
import Combine

final class viewModelHeros: ObservableObject {
    @Published var heros: [Heros]?
    @Published var status = Status.none
    
    private var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if(testing) {
            getherosTesting()
        }else {
            getHeros(filter: "")
        }
    }
    
    //IR CANCELANDO SUSCRIPTORES
    func cancelAll() {
        suscriptors.forEach { AnyCancellable in
            AnyCancellable.cancel()
        }
    }
    
    //FUNCION PARA DATOS HEROES REALES
    func getHeros(filter: String) {
        //voy cancelando suscriptores
        cancelAll()
        //Combine para traer heroes
        self.status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionHeros(filter: filter))
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                //devolvemos los datos que es el JSON
                return $0.data
            }
            .decode(type: [Heros].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.status = Status.loaded
                case .failure:
                    self.status = Status.error(error: "Error buscando heros")
                }
            } receiveValue: { data in
                self.heros = data
            }
            .store(in: &suscriptors)

    }
    
    //MARK: FUNCION PARA DATOS DE PRUEBA
    func getherosTesting() {
        //Crear array de 4 heroes y asignarlos heros
        let hero1 = Heros(id: UUID(),
            name: "Goku",
            description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
            photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
            favorite: true)
                
        let hero2 = Heros(id: UUID(),
                          name: "Vegeta",
                          description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.",
                          photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
                          favorite: false)
                
        let hero3 = Heros(id: UUID(),
                          name: "Freezer",
                          description: "Freezer es el villano más temido del universo Dragon Ball, es la maldad personificada. Es el responsable de la muerte de los padres de Goku, del Rey Vegeta, de los Saiyan del Planeta Vegeta, donde provocó un genocidio. La serie mostró en varias ocasiones su crueldad, ya que disfruta de la muerte y del sufrimiento de sus víctimas. Y no tiene límites. Freezer es la razón por la que Vegeta termina uniéndose a Goku. Tanto Vegeta como Freezer desean la inmortalidad, así que ambos compiten por reunir las bolas de Dragón. Finalmente todos se enfrentan a él. El propio Piccolo es resucitado y trasladado a Namek para enfrentarse al villano. Pronto revelará que tiene varias transformaciones más poderosas, siendo la forma final la más fuerte de todas. Trunks del Futuro consigue matarle, aunque más tarde será revivido para volver a dar guerra en Dragon Ball Super.",
                          photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/freezer-dragon-ball-bebe-abj.jpg?width=300",
                          favorite: true)
                
        let hero4 = Heros(id: UUID(),
                          name: "Krilin",
                          description: "Krilin lo tiene todo. Cuando aún no existían los 'memes', Krilin ya los protagonizaba. Junto a Yamcha ha sido objeto de burla por sus desafortunadas batallas en Dragon Ball Z. Inicialmente, Krilin era el mejor amigo de Goku siendo sólo dos niños que querían aprender artes marciales. El Maestro Roshi les entrena para ser dos grandes luchadores, pero la diferencia entre ambos cada vez es más evidente. Krilin era ambicioso y se ablanda con el tiempo. Es un personaje que acepta un papel secundario para apoyar el éxito de su mejor amigo Goku de una forma totalmente altruista.",
                          photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/08/Krilin.jpg?width=300",
                          favorite: false)
        
        self.heros = [hero1, hero2, hero3, hero4]

        //cambiar el estado a cargado
        self.status = .loaded
    }
    
    
}




let hero1 = Heros(id: UUID(), name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300", favorite: true)
        
        let hero2 = Heros(id: UUID(), name: "Vegeta", description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300", favorite: false)
        
        let hero3 = Heros(id: UUID(), name: "Freezer", description: "Freezer es el villano más temido del universo Dragon Ball, es la maldad personificada. Es el responsable de la muerte de los padres de Goku, del Rey Vegeta, de los Saiyan del Planeta Vegeta, donde provocó un genocidio. La serie mostró en varias ocasiones su crueldad, ya que disfruta de la muerte y del sufrimiento de sus víctimas. Y no tiene límites. Freezer es la razón por la que Vegeta termina uniéndose a Goku. Tanto Vegeta como Freezer desean la inmortalidad, así que ambos compiten por reunir las bolas de Dragón. Finalmente todos se enfrentan a él. El propio Piccolo es resucitado y trasladado a Namek para enfrentarse al villano. Pronto revelará que tiene varias transformaciones más poderosas, siendo la forma final la más fuerte de todas. Trunks del Futuro consigue matarle, aunque más tarde será revivido para volver a dar guerra en Dragon Ball Super.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/freezer-dragon-ball-bebe-abj.jpg?width=300", favorite: true)
        
        let hero4 = Heros(id: UUID(), name: "Krilin", description: "Krilin lo tiene todo. Cuando aún no existían los 'memes', Krilin ya los protagonizaba. Junto a Yamcha ha sido objeto de burla por sus desafortunadas batallas en Dragon Ball Z. Inicialmente, Krilin era el mejor amigo de Goku siendo sólo dos niños que querían aprender artes marciales. El Maestro Roshi les entrena para ser dos grandes luchadores, pero la diferencia entre ambos cada vez es más evidente. Krilin era ambicioso y se ablanda con el tiempo. Es un personaje que acepta un papel secundario para apoyar el éxito de su mejor amigo Goku de una forma totalmente altruista.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/08/Krilin.jpg?width=300", favorite: false)
