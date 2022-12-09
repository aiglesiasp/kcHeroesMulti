//
//  BaseNetwork.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 6/12/22.
//

import Foundation

//Creo el servidor
let server = "https://dragonball.keepcoding.education"

//Creo los medotos
struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let content = "application/json"
}

//Endpoints
enum endpoints: String {
    case login = "/api/auth/login"
    case herosList = "/api/heros/all"
}

//CREO EL REQUEST A LAS LLAMADAS
struct BaseNetwork {
    
    
    //MARK: PARA GENERAR EL LOGIN
    func getSessionLogin(user: String, password: String) -> URLRequest {
        //Montamos la cadena URL
        let urlCad: String = "\(server)\(endpoints.login.rawValue)"
        //Encriptamos credenciales de usuario y password
        let encodeCredential = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        //DESEPAQUETAMOS
        var segCredential = ""
        
        if let credential = encodeCredential {
            segCredential = "Basic \(credential)"
        }
        
        //Creamos la REQUEST
        var request = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredential, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    //MARK: FUNCION OBTENER HEROES
    func getSessionHeros(filter: String) -> URLRequest {
        //Montamos la cadena URL
        let urlCad: String = "\(server)\(endpoints.herosList.rawValue)"
        //Creamos la REQUEST
        var request = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        //Genero el JSON de la request
        request.httpBody = try? JSONEncoder().encode(HerosFilter(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        //Seguridad token
        let token = loadKC(key: CONST_TOKEN_ID)
        if let tokenJWT = token {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
