//
//  PrincipalView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct PrincipalView: View {
    var model: viewModelHeros = viewModelHeros()
    var body: some View {
        TabView {
            HerosView(viewModel: model)
                .tabItem {
                    Image(systemName: "house")
                    Text("Heroes")
                }
        }
    }
}


struct PrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalView()
    }
}
