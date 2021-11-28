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
                    MapPinView(user: user)
                        .foregroundColor(.blue)
                        .offset(x: 0, y: -5)
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

