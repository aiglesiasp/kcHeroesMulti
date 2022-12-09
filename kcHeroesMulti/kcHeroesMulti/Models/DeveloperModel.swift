//
//  DevelopersModel.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 9/12/22.
//

import Foundation

//MARK: - Developers -
struct Developer: Codable, Identifiable {
    let bootcamp: Bootcamp
    let id: String
    let apell1: String
    let apell2: String
    let email: String
    let name: String
    let photo: String
    let heros: [Heros] //heroes favoritos de un developer
}


//MARK: - Bootcamp -
struct Bootcamp: Codable, Identifiable{
    let id: String
    let name: String
}
