//
//  HerosDetailView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 9/12/22.
//

import SwiftUI

struct HerosDetailView: View {
    var hero: Heros
    @ObservedObject var viewModelHeros: viewModelHeros
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            VStack {
                
                //MARK: CABECERA NOMBRE
                HStack {
                    Text("\(hero.name)")
                        .bold()
                        .font(.title)
                    Spacer()
                    Button {
                        //TODO: action me gusta
                    } label: {
                        if (hero.favorite!) {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 40, height: 40)
                                .padding([.leading, .trailing], 10)
                            
                            
                        } else {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 40, height: 40)
                                .padding([.leading, .trailing], 10)
                        }
                    }
                }
                .padding([.leading, .trailing], 10)
                //MARK: FOTO
                AsyncImage(url: URL(string: hero.photo)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding([.trailing, .leading], 10)
                        .opacity(0.6)
                        
                    
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding([.trailing, .leading], 10)
                        .opacity(0.6)
                }
                //MARK: DESCRIPCION
                Text("\(hero.description)")
                    .foregroundColor(.gray)
                    .font(.caption2)
                    .padding()
                
                
                
            }//Fin VSTACK
        }//FIn SCROLL
    }//FIN body
}//Fi VIEW
        

struct HerosDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HerosDetailView(hero: Heros(id: UUID(),
                                    name: "Goku",
                                    description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
                                    photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
                                    favorite: true), viewModelHeros: viewModelHeros())
    }
}
