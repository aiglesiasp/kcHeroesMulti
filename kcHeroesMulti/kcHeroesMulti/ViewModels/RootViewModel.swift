//
//  RootViewModel.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 6/12/22.
//

import Foundation
import Combine

public let CONST_TOKEN_ID = "tokenJWTKeyChainIOSSuperpoderes"

final class RootViewModel: ObservableObject {
    //Propiedad estado
    @Published var status = Status.none
    @Published var bootcamps: [Bootcamp]?
    //Creo el suscriptor porque voy a usar Combine
    private var suscriptors = Set<AnyCancellable>()
    
    //MARK: KeyChain
    @kcPersistenceKeyChain(key: CONST_TOKEN_ID)
    var tokenJWT {
        didSet {
            print("me asignan: \(tokenJWT)")
        }
    }
    
    //MARK: inicializador
    init(testing: Bool = false) {
        self.logedUserControl()
        
        if(!testing) {
            loadBootCamps()
        } else {
            //mockeo los bootcamps
            loadBootCampsTesting()
        }
        
    }
    
    //MARK: funcion para comprobar token
    func logedUserControl() {
        if tokenJWT != "" {
            self.status = .loaded
        }
    }
    
    
    //MARK: FUNCION COMPROBAR TOKEN ANTIGUO
    /*
    //Para guardar el token
    @Published var tokenJWT: String = "" {
        didSet {
            if tokenJWT != "" {
                saveKC(key: CONST_TOKEN_ID, value: tokenJWT) //persisitido en keychain
                print("Token: \(tokenJWT)")
            }
        }
    }
     */
    
    /*
    func logedUserControl() {
        let tokenSaved = loadKC(key: CONST_TOKEN_ID)
        if let token = tokenSaved {
            tokenJWT = token
            
            if token.count > 0 {
                self.status = .loaded //Cambio el estado a Cargado para que no vaya al Login
            }
        }
    }
     */
    
    //MARK: FUNCION CERRAR SESSION
    func closeSession() {
        self.tokenJWT = ""
        self.status = .none //va al login
    }
    
    
    //MARK: LOGIN AL SERVIDOR
    func login(user: String, password: String) {
        self.status = .loading //estado cargando
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionLogin(user: user, password: password))
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                //devolvemos la cadena porque es el token JWT
                return String(decoding: $0.data, as: UTF8.self)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = .error(error: "Usuario y/o Contraseña erronea")
                case .finished:
                    self.status = .loaded //LOGIN OKEY
                }
            } receiveValue: { token in
                self.tokenJWT = token
            }
            .store(in: &suscriptors)

    }
    
    //MARK: FUNCION CARGAR BOOTCAMPS
    func loadBootCamps() {
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionBootcamps())
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                //devolvemos la cadena porque es el token JWT
                return $0.data
            }
            .decode(type: [Bootcamp].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { data in
                self.bootcamps = data
            }
            .store(in: &suscriptors)
    }
    
    //MARK: FUNCION SIMULAR BOOTCAMPS
    func loadBootCampsTesting() {
        let b1 = Bootcamp(id: UUID().uuidString, name: "Mobile 11")
        let b2 = Bootcamp(id: UUID().uuidString, name: "Mobile 12")
        let b3 = Bootcamp(id: UUID().uuidString, name: "Mobile 13")
        let b4 = Bootcamp(id: UUID().uuidString, name: "Mobile 14")
        self.bootcamps = [b1, b2, b3, b4]
    }
    
}
