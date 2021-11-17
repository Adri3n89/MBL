//
//  MapView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.34, longitude: 3.06), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

        var body: some View {
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                    .frame(width: width, height: height)
            }
        }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

