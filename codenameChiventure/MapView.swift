//
//  MapView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import MapKit
import HalfASheet

// TODO: Add Pins of Surrounding Places?

struct MapView: View {
    @EnvironmentObject var router:TabRouter
    @State var viewModel = ContentViewModel()
    @State private var isPresented:Bool = false

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
            HalfASheet(isPresented: $isPresented, title: "Places for you") {
                List {
                    Text("A List Item")
                    Text("A Second List Item")
                    Text("A Third List Item")
                }
            }
            .ignoresSafeArea()
            
            HStack(alignment: .top) {
                Button {
                    isPresented = !isPresented
                } label: {
                    Label("Show Results", systemImage: "flag.fill")
                        .padding()
                        .background(.regularMaterial)
                }
            }
        }
    }
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: 41.883718,
                                    longitude: -87.632382
                                ),
                                span: MKCoordinateSpan(
                                    latitudeDelta: 0.25,
                                    longitudeDelta: 0.25
                                )
                            )
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            // Activity Type
            locationManager!.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("Hey you didn't let us access your location bro")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
               locationManager.requestWhenInUseAuthorization()
            case .restricted:
               print("Ask your mum.")
            case .denied:
               print("Boi 👏 😤 👋")
            case .authorizedAlways, .authorizedWhenInUse:
                print("test")
                region = MKCoordinateRegion(
                    center: locationManager.location!.coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 1.5,
                        longitudeDelta: 1.5
                    )
                )
            @unknown default:
                break
                       
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
