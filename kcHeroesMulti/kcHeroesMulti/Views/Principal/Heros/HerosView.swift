//
//  HerosView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct HerosView: View {
    @StateObject var viewModel: viewModelHeros
    @State private var filter: String = ""
    
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
            .searchable(text: $filter, prompt: "Buscar un heroe...")
            .onChange(of: filter, perform: { newValue in
                viewModel.getHeros(filter: newValue)
                //print("filtro: \(newValue)")
            })
            .onDisappear{
                //hacer algo cuando se acaba la pantalla
            }
            .onAppear{
                //Ejemplo: llamar a un metodo del viewModel antes de cargar la vista
            }
        }
    }
}

struct HerosView_Previews: PreviewProvider {
    static var previews: some View {
        HerosView(viewModel: viewModelHeros(testing: true))
    }
}
