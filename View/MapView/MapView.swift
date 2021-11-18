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
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.allCoordinates, annotationContent: { coord in
                MapMarker(coordinate: coord.coordinates , tint: .blue)
            })
                .onAppear {
                    viewModel.geoCode(addresses: viewModel.allAdress) { placemarks in
                        for index in 0...placemarks.count-1 {
                            viewModel.allCoordinates.append(Coord(coordinates: CLLocationCoordinate2D(latitude: (placemarks[index].location?.coordinate.latitude)! , longitude: (placemarks[index].location?.coordinate.longitude)!)))
                        }
                    }
                }
        }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

