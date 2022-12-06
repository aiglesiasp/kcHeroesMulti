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
}

//CREO EL REQUEST A LAS LLAMADAS
struct BaseNetwork {
    
    
    //PARA GENERAR EL LOGIN
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
}