//
//  FavoriteDevelopersView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 9/12/22.
//

import SwiftUI

struct FavoriteDevelopersView: View {
    var data: Developer
    @Environment(\.presentationMode) private var presentationMode //to close el modal
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ForEach(data.heros) { hero in
                    VStack {
                        Text("\(hero.name)")
                        AsyncImage(url: URL(string: hero.photo))
                            .frame(width: 300, height: 200)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                }
                Spacer()
                Button {
                    //TODO:
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cerrar")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.orange)
                        .cornerRadius(20)
                }

            }
                
            }
        }
}

struct FavoriteDevelopersView_Previews: PreviewProvider {
    static var previews: some View {
       let hero1 = Heros(id: UUID(),name: "Goku",
                                 description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
                                 photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
                         favorite: true)
        
        let hero2 = Heros(id: UUID(),
                                 name: "Goku",
                                 description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
                                 photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
                                 favorite: true)
        
        
        FavoriteDevelopersView(data: Developer(bootcamp: Bootcamp(id: "", name: "BootcampMobile 14"), id: "100", apell1: "Iglesias", apell2: "Pubill", email: "", name: "Aitor", photo: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", heros:[hero1, hero2] ))
    }
}
