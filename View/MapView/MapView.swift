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
                    Image(systemName: "pin.fill")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            viewModel.showLibrary.toggle()
                        }
                        .sheet(isPresented: $viewModel.showLibrary) {
                            PublicProfilView(userID: user.userID)
                        }
                }
            })
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

