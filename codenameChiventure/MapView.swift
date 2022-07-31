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
    @EnvironmentObject var router:TabRouter
    @State var viewModel = ContentViewModel()
    @State private var isPresented:Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
            
            HStack {
                Text("0 Results")
                    .foregroundColor(.secondary)
                
                Button {
                    isPresented = !isPresented
                } label: {
                    Label("Show Results", systemImage: "mappin.and.ellipse")
                        .badge(5)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.thinMaterial)
        }
        .sheet(isPresented: $isPresented, content: {
            ResultsView()
        })
    }
}

struct ResultsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
                .ignoresSafeArea()
            
            VStack {
                Button(role: .cancel, action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding(20)
                })
                
                Text("Places Around You")
                    .font(.title)
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
//                region = MKCoordinateRegion(
//                    center: locationManager.location!.coordinate,
//                    span: MKCoordinateSpan(
//                        latitudeDelta: 0.025,
//                        longitudeDelta: 0.025
//                    )
//                )
            @unknown default:
                break
                       
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
