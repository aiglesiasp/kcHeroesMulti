//
//  StatusModel.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 6/12/22.
//

import Foundation

enum Status {
    case none, loading, loaded, register, error(error: String)
}
