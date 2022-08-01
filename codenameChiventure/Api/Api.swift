////
////  Api.swift
////  codenameChiventure
////
////  Created by Anthony Valenzo on 8/1/22.
////
//
//import Foundation
//
//struct Place: Codable, Identifiable {
//    var id = UUID()
//    let name: String
////    let category: Category
////    let address: String // TODO: Convert to Address
////    var image: Image?
//}
//class apiCall {
//    func getPlaces(completion:@escaping ([Place]) -> ()) {
//        guard let url = URL(string: "https://codename-chiven.glitch.me/") else { return }
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            let places = try! JSONDecoder().decode([Place].self, from: data!)
//            print(places)
//            
//            DispatchQueue.main.async {
//                completion(places)
//            }
//        }
//        .resume()
//    }
//}
