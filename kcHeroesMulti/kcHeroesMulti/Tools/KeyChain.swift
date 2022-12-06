//
//  KeyChain.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 6/12/22.
//

import KeychainSwift
//MARK: FUNCION SAVE
@discardableResult
func saveKC(key: String, value: String) -> Bool {
    if let data = value.data(using: .utf8) {
        let keychain = KeychainSwift()
        keychain.set(data, forKey: key)
        return true
    } else  {
        return false
    }
}
//MARK: FUNCION READ
func loadKC(key: String) -> String? {
    let keychain = KeychainSwift()
    if let data = keychain.get(key) {
        return data
    }
    return ""
}
//MARK: FUNCION ELIMINAR
func deleteKC(key: String){
    let keychain = KeychainSwift()
    keychain.delete(key)
}
