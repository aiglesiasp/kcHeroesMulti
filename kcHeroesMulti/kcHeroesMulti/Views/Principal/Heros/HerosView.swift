//
//  HerosView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct HerosView: View {
    @StateObject var viewModel: viewModelHeros
    
    var body: some View {
        NavigationView {
            List {
                if let heros = viewModel.heros {
                    ForEach(heros) { hero in
                        NavigationLink {
                            //Pantalla del detalle
                            Text("\(hero.name)")
                        } label: {
                            //Detalle de la row
                            HerosRowView(hero: hero)
                        }

                    }
                }
            }
        }
    }
}

struct HerosView_Previews: PreviewProvider {
    static var previews: some View {
        HerosView(viewModel: viewModelHeros(testing: true))
    }
}
