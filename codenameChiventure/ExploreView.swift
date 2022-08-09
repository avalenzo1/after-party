//
//  ExploreView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import MapKit

// TODO: Add Pins of Surrounding Places?

struct ExploreView: View {
    @EnvironmentObject var router:TabRouter
    @StateObject var apiViewModel = APIViewModel()
    @StateObject var mapViewModel = MapViewModel()
    @State private var isPresented:Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(mapViewModel: mapViewModel)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                apiViewModel.fetchPlaces()
            }

            HStack {
                Button {
                    isPresented = !isPresented
                } label: {
                    Text("\(5)")
                        .foregroundStyle(palette[0])
                    Text("Pins")
                    Image(systemName: "chevron.up")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .foregroundColor(.secondary)
                
                Button(action: {
                    
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
        .refreshable {
            apiViewModel.fetchPlaces()
        }
        .sheet(isPresented: $isPresented, content: {
            ResultsView(apiViewModel: self.apiViewModel)
        })
    }
}

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let category: Category
    let address: String // TODO: Convert to Address
    var imageURL: String?
}

struct ResultCard: View {
    let Place: Place
    
    var body: some View {
        HStack(alignment: .center, spacing: 25) {
            AsyncImage(
                url: URL(string: Place.imageURL ?? "https://cdn.glitch.global/ef484321-67dd-403c-bd98-f2a70bb3d393/placerholder.png?v=1659467173088")
            ) { image in
                Color.gray
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        image
                            .resizable()
                            .scaledToFill()
                        )
                    .clipShape(Rectangle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .cornerRadius(25)
            
            VStack(alignment: .center, spacing: 5) {
                Text(Place.name)
                    .font(.title)
                Text(Place.address)
                    .font(.body)
            }
            .frame(maxWidth: .infinity)
        }
        .background(.white.opacity(0.1))
        .frame(maxWidth: .infinity, maxHeight: 150)
        .cornerRadius(25)
        .padding(.horizontal, 25)
    }
}

struct ResultsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var apiViewModel: APIViewModel
    
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
                    
                    VStack(spacing: 20) {
                        if (apiViewModel.isLoading) {
                            ProgressView()
                        } else {
                            ForEach(apiViewModel.places, id: \.self) { place in
                                ResultCard(Place: Place(name: place.name, category: Category(rawValue: place.category) ?? .other, address: place.address, imageURL: place.imageURL))
                            }
                        }
                    }
                    .onAppear {
                        apiViewModel.fetchPlaces()
                        print("BRUH")
                    }
                    .refreshable {
                        apiViewModel.fetchPlaces()
                    }
                }
            }
        }
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var mapPins: [PlacePin] = [
        PlacePin(coordinate: CLLocationCoordinate2D(latitude: 41.885728, longitude: -87.632682)),
        PlacePin(coordinate: CLLocationCoordinate2D(latitude: 41.883729, longitude: -87.634483)),
    ]
}
