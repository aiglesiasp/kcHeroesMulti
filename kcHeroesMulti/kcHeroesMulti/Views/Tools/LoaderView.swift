//
//  LoaderView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        
        ZStack {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.orange)
            
            Text("Cargando...")
                .foregroundColor(.white)
                .font(.title2)
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
