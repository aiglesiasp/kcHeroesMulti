//
//  LoginView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 5/12/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var rootViewModel: RootViewModel
    
#if DEBUG
    @State private var email = "aiglesiaspubill@gmail.com"
    @State private var password = ""
#else
    @State private var email = ""
    @State private var password = ""
#endif
    
    
    
    
    
    @State private var animationAmounth = 1.0
    
    var body: some View {
        //MARK: Imagen de fondo
        ZStack {
            //agrego imagen
            Image(decorative: "backgroundLogin")
                .resizable()
                .opacity(1)
            //agrego capa oscura
            Image(decorative: "")
                .resizable()
                .background(.black)
                .opacity(0.3)
            
            //MARK: Añadimos el titulo
            VStack {
                Image(decorative: "title")
                    .resizable()
                    .scaledToFit() //escalar
                    .frame(width: 300)
                    .opacity(0.8)
                    .padding(.top, 160) //padding desde posicion central
                Spacer()
                //MARK: Añadiendo cuadro con TextFields
                VStack {
                    //PARA EL EMAIL
                    TextField("Correo", text: $email)
                        .padding()
                        .font(.custom("", size: 18))
                        .background(.white)
                        .foregroundColor(Color.blue)
                        .cornerRadius(20.0)
                        .shadow(radius: 1.0, x:10, y:10) //dar sombra
                        //.autocapitalization(.none) //antes de iOS16
                        .textInputAutocapitalization(.never) //ioS16
                        //.disableAutocorrection(true) //antes de iOS16
                        .autocorrectionDisabled() //iOS16
                        .opacity(0.8)
                    
                    //PARA EL PASSWORD
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .font(.custom("", size: 18))
                        .background(.white)
                        .foregroundColor(Color.blue)
                        .cornerRadius(20.0)
                        .shadow(radius: 1.0, x:10, y:10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .opacity(0.8)
                        .padding(.top, 20)
                    
                    //MARK: Agrego el boton de Usuario
                    Button {
                        //Login en el viemodel
                        rootViewModel.login(user: email, password: password)
                    } label: {
                        Text("ENTRAR")
                            //.font(.title2)
                            .font(.custom("", size: 25))
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color(.blue))
                            .cornerRadius(20)
                            .shadow(radius: 1.0, x:10, y:10)
                    }
                    .padding(.top, 50)
                    .opacity(0.8)
                    //añado animacion
                    .overlay(
                        Circle()
                            .stroke(Color.white)
                            .scaleEffect(animationAmounth)
                            .opacity(2-animationAmounth)
                            .animation(.easeInOut(duration: 1).repeatForever(), value: animationAmounth)
                            .padding(.top, 50)
                    )
                    .onAppear{
                        animationAmounth = 2
                    }
                    
                }
                .padding([.leading, .trailing], 15)
                
                //MARK: añado parte de registro
                Spacer()
                ZStack {
                    
                    //agrego capa oscura
                    Image(decorative: "")
                        .resizable()
                        .frame(height: 30)
                        .background(.black)
                        .opacity(0.6)
                    
                    HStack {
                        Text("¿No tienes cuenta?")
                            .foregroundColor(.white)
                            .bold()
                        Button {
                            //TODO: abrir view de registro
                        } label: {
                            Text("Registro")
                                .foregroundColor(.blue)
                                .bold()
                        }
                    }
                    .padding()
                }
            }
            
        }//fin Zstack
        .ignoresSafeArea()
        
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
