//
//  MapView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    
    @StateObject var viewModel = MapViewModel()

        var body: some View {
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.allCoordinates, annotationContent: { user in
                MapAnnotation(coordinate: user.coordinates) {
                    MapPinView(name: user.name, lastName: user.lastName)
                        .foregroundColor(.blue)
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

