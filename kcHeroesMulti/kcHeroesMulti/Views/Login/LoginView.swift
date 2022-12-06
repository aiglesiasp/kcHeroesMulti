//
//  LoginView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 5/12/22.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("ENTRAR")
                .foregroundColor(.yellow)
                .bold()
                .frame(width: 200, height: 200)
                .font(.title)
            Spacer()
            Text("Hola me llamo")
                .background(.red)
            
            Spacer()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environment(\.locale, .init(identifier: "es"))
        
        LoginView()
            .environment(\.locale, .init(identifier: "en"))
    }
    
    
}
