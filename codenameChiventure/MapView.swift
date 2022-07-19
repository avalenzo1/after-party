//
//  MapView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    // 2.
    @State private var region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 41.883718,
                    longitude: -87.632382),
                span: MKCoordinateSpan(
                    latitudeDelta: 1.0,
                    longitudeDelta: 1.0)
                )

    var body: some View {
        // 3.
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
}
