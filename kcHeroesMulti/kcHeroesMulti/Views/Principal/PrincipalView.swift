//
//  PrincipalView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct PrincipalView: View {
    var body: some View {
        TabView {
            VStack {
                HerosView(viewModel: viewModelHeros())
            }
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
