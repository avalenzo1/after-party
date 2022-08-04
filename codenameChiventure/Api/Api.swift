//
//  Api.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 8/1/22.
//

import Foundation
import CoreLocation

struct PlaceJSON: Hashable, Codable {
    let name: String
    let category: String
    let imageURL: String
    let address: String
    let coordinate: Coordinate
}

struct Coordinate: Hashable, Codable {
    let latitude, longitude: Double
}

class APIViewModel: ObservableObject {
    @Published var places: [PlaceJSON] = []
    @Published var isLoading: Bool = true
    
    func fetchPlaces() {
        let serialized_url: String = "https://after-party.glitch.me/places/"
        
        guard let url = URL(string: serialized_url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _,
            error in
            guard let data = data, error == nil else {
                return
            }
 
            // Convert to JSON
            
            do {
                let places = try JSONDecoder().decode([PlaceJSON].self, from: data)
                DispatchQueue.main.async {
                    self?.places = places
                    self?.isLoading = false
                    print("dog water")
                    print(self?.places)
                }
            } catch {
                print("An error occured!")
                print("\(error)")
            }
        }
        
        print("BRUH")
        
        task.resume() 
    }
}
