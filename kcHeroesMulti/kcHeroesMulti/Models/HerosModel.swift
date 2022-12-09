//
//  HerosModel.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import Foundation

//RESPUESTA SERVIDOR
struct Heros: Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var photo: String
    var favorite: Bool?
}

//PARA FILTRO DE SERVER
struct HerosFilter: Codable {
    var name: String
}


//request like hero
struct HeroLikeRequest: Codable {
    var hero: String
}
