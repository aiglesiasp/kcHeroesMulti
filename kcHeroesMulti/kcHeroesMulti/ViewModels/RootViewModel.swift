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
    //Para guardar el token
    @Published var tokenJWT: String = "" {
        didSet {
            saveKC(key: CONST_TOKEN_ID, value: tokenJWT) //persisitido en keychain
            print("Token: \(tokenJWT)")
        }
    }
    //Creo el suscriptor porque voy a usar Combine
    private var suscriptors = Set<AnyCancellable>()
    
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
    
}
