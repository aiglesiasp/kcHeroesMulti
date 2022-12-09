//
//  DevelopersView.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 9/12/22.
//

import SwiftUI

struct DevelopersView: View {
    @StateObject var viewModel: viewModelDevelopers
    @EnvironmentObject var viewmodelRoot: RootViewModel
    
    var body: some View {
        ScrollView {
            //Step1. Iterate with bootcamp
            if let boots = viewmodelRoot.bootcamps,
               let developers = viewModel.developers {
                //tenemos boots y developers
                ForEach(boots) { boot in
                    //busco los developers
                    let dataFIlter = viewModel.getDevelopersOfBootcamp(id: boot.id)
                    if dataFIlter.count > 0 {
                        //Hay developers
                        
                        VStack(alignment: .leading) {
                            //titulo del bootcamp
                            Text(boot.name)
                                .font(.title)
                                .foregroundColor(.orange)
                                .bold()
                            //Lista horizontal de developers tipo netflix
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack {
                                    ForEach(dataFIlter) { developer in
                                        DevelopersRowView(data: developer)
                                    }
                                }
                            }
                            
                        }
                    }
                }
            } else {
                Text("Sin datos")
            }
            //Step2. Developers of bootcamp
            
        }
    }
}

struct DevelopersView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let rootvm = RootViewModel(testing: true)
        let viemModelDev = viewModelDevelopers(testing: true, boot: rootvm.bootcamps!)
        
        DevelopersView(viewModel: viemModelDev)
            .environmentObject(rootvm)
    }
}
