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
    //Capturar el ENVIRONMENT DEL VIEWMODEL
   @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if let heros = viewModel.heros {
                    ForEach(heros) { hero in
                        NavigationLink {
                            //Pantalla del detalle
                            HerosDetailView(hero: hero, viewModelHeros: viewModel)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //TODO: cerrar sesion
                        rootViewModel.closeSession()
                    } label: {
                        HStack {
                            Image(systemName: "xmark.circle")
                                .font(.caption)
                                .foregroundColor(.blue)
                            Text("Close Session")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }

                }
            }
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
