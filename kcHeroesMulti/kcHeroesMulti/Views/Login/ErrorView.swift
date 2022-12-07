//
//  ErrorView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var viewModel: RootViewModel
    
    private var textError: String
    
    init(textError: String) {
        self.textError = textError
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.bubble")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 200, height: 200)
                .padding()
            Text(textError)
                .foregroundColor(.red)
                .font(.headline)
            Spacer()
            Button {
                //Volver al login...
                viewModel.status = .none
            } label: {
                Text("Volver Login")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(15.0)
                    .shadow(radius: 1, x: 10.0, y: 10.0)
            }

        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(textError: "Prueba de error")
    }
}
