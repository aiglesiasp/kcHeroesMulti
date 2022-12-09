//
//  DevelopersRowView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 9/12/22.
//

import SwiftUI

struct DevelopersRowView: View {
    var data: Developer
    
    var body: some View {
        VStack {
            //foto
            AsyncImage(url: URL(string: data.photo)) { Image in
                Image
                    .resizable()
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.orange, lineWidth: 5))
                    .frame(width: 100, height: 100)
                    .padding()
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.orange, lineWidth: 5))
                    .frame(width: 100, height: 100)
                    .padding()
            }
            
            //nombre y apellido 1
            Text("\(data.name) \(data.apell1)")
                .font(.caption)
                .foregroundColor(.orange)
        }
    }
}

struct DevelopersRowView_Previews: PreviewProvider {
    static var previews: some View {
        DevelopersRowView(data: Developer(bootcamp: Bootcamp(id: "01", name: "Bootcamp 14"), id: "100", apell1: "Iglesias", apell2: "Pubill", email: "", name: "Aitor", photo: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", heros: []))
    }
}
