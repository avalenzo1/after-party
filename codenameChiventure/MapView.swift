//
//  MapView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import MapKit

// TODO: Add Pins of Surrounding Places?

struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

var annotationItems: [MyAnnotationItem] = [
    MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 41.883728, longitude: -87.632482)),
    MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 41.883729, longitude: -87.632483)),
]

struct MapView: View {
    @EnvironmentObject var router:TabRouter
    @State var viewModel = ContentViewModel()
    @State private var isPresented:Bool = false
    
    init() {
        viewModel.checkIfLocationServicesIsEnabled()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: annotationItems) {item in
                MapPin(coordinate: item.coordinate)
            }
            .edgesIgnoringSafeArea(.all)
            
            HStack {
                Button {
                    isPresented = !isPresented
                } label: {
                    Text("\(20)")
                        .foregroundStyle(palette[0])
                    Text("Pins")
                    Image(systemName: "chevron.up")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .foregroundColor(.secondary)
                
                Button(action: {
                    viewModel.checkIfLocationServicesIsEnabled()
                }) {
                    Image(systemName: "location")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
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

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let category: Category
    let address: String // TODO: Convert to Address
    var image: Image?
}

struct ResultCard: View {
    let Place: Place
    
    var body: some View {
        HStack(spacing: 25) {
            Image("placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(25)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(Place.name)
                    .font(.title)
                Text(Place.address)
                    .font(.body)
            }
        }
        .padding()
        .frame(height: 150)
    }
}

struct ResultsView: View {
    @Environment(\.presentationMode) var presentationMode
    let results: Array<Place> = [
        Place(name: "Irving Park", category: .park, address: "2741 W Montrose Ave, Chicago, IL 60618"),
        Place(name: "Irving Park", category: .park, address: "2741 W Montrose Ave, Chicago, IL 60618"),
        Place(name: "Irving Park", category: .park, address: "2741 W Montrose Ave, Chicago, IL 60618"),
        Place(name: "Irving Park", category: .park, address: "2741 W Montrose Ave, Chicago, IL 60618"),
        Place(name: "Irving Park", category: .park, address: "2741 W Montrose Ave, Chicago, IL 60618"),
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
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
                    
                    VStack(spacing: 10) {
                        ForEach(results) { result in
                            ResultCard(Place: result)
                        }
                    }
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
            locationManager!.delegate = self
        } else {
            print("Hey you didn't let us access your location bro")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Ask your mum.")
        case .denied:
            print("Boi 👏 😤 👋")
        case .authorizedAlways, .authorizedWhenInUse:
            region.center = locationManager.location!.coordinate
            region.span = MKCoordinateSpan(
                    latitudeDelta: 0.025,
                    longitudeDelta: 0.025
                )
            
            print("if this shows in console, then region SHOULD update")
        @unknown default:
            break
            
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
