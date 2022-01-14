//
//  MapView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var viewModel = MapViewModel()

        var body: some View {
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.allCoordinates, annotationContent: { user in
                MapAnnotation(coordinate: user.coordinates) {
                    Image(systemName: Constantes.pin)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            viewModel.showLibrary.toggle()
                            viewModel.userToShow = user.userID
                        }
                }
            })
            .sheet(isPresented: $viewModel.showLibrary) {
                PublicProfilView(userID: viewModel.userToShow)
            }
            .onAppear {
                viewModel.getAllUsers()
            }
        }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

