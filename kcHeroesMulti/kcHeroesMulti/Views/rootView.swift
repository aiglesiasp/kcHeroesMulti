//
//  rootView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct rootView: View {
     //Capturar el ENVIRONMENT DEL VIEWMODEL
    @EnvironmentObject var rootViewModel: RootViewModel

    var body: some View {
        switch(rootViewModel.status) {
        case Status.none:
            LoginView()
        case Status.register:
            Text("vista registro")
        case Status.loading:
            Text("Vista loading")
        case Status.error(error: let errorString):
            Text("error viene: \(errorString)")
        case Status.loaded:
            Text("Login OK, cargamos la HOME")
        }
    }
}

struct rootView_Previews: PreviewProvider {
    static var previews: some View {
        rootView()
            .environmentObject(RootViewModel())
    }
}
