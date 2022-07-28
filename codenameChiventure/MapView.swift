//
//  MapView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import MapKit

// TODO: Add Pins of Surrounding Places?

struct MapView: View {
    @State private var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 41.883718,
                    longitude: -87.632382),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.25,
                    longitudeDelta: 0.25)
                )

    var body: some View {
        
        Map(coordinateRegion: $region, showsUserLocation: true)
            .edgesIgnoringSafeArea(.all)
    }
}
