//
//  TestMapView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 8/1/22.
//

import Foundation
import SwiftUI
import MapKit

struct PlacePin: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct MapView: UIViewRepresentable {
    let manager = CLLocationManager()
    @StateObject var mapViewModel: MapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        map.setUserTrackingMode(.followWithHeading, animated: true)
        map.setRegion(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 41.883718,
                        longitude: -87.632382
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.25,
                        longitudeDelta: 0.25
                    )
                ), animated: true)
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestWhenInUseAuthorization()
        
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var myMapView: MapView
        
        init(_ map : MapView) {
            self.myMapView = map
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            UIView.animate(withDuration: 0.1) {
                mapView.setRegion(region, animated: true)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
