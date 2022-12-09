//
//  PrincipalView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct PrincipalView: View {
    var herosModel: viewModelHeros = viewModelHeros()
    var developersModel: viewModelDevelopers = viewModelDevelopers()
    
    var body: some View {
        TabView {
            HerosView(viewModel: herosModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Heroes")
                }
            
            DevelopersView(viewModel: developersModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Developers")
                }
        }
        .accentColor(.orange)
    }
}


struct PrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalView()
    }
}
