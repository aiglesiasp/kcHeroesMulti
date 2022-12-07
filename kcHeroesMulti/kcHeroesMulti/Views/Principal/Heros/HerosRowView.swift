//
//  HerosRowView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import SwiftUI

struct HerosRowView: View {
    var hero: Heros
    
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: hero.photo)) { photoDownload in
                
                photoDownload
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    .opacity(0.6)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    .opacity(0.6)
            }
            Text("\(hero.name)")
                .font(.title2)
                .padding([.top, .leading], 10)
            
            if hero.favorite! {
                Image(systemName: "heart.circle")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 40, height: 40)
                    .offset()
            }else {
                Image(systemName: "heart.circle")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
        }
    }
}

struct HerosRowView_Previews: PreviewProvider {
    static var previews: some View {
        HerosRowView(hero: Heros(id: UUID(),
                                 name: "Goku",
                                 description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
                                 photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
                                 favorite: true))
        .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/330.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
    }
}
