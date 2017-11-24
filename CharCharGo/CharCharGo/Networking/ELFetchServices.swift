//
//  ELNetworkManager.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/19/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation
import UIKit

class ELFetchServices {
    
    static let kSimpsonCharacterURL = "https://api.duckduckgo.com/?q=simpsons+characters&format=json"
    
    func fetchDuckDuckGoCharachtersService(completion: @escaping (ELCharacterProfileArray?) -> Void) {
        
        guard let url = URL(string: ELFetchServices.kSimpsonCharacterURL) else {
            print("Error: cannot create URL")
            completion(nil)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        //urlRequest.httpMethod = "GET"
        
        //let config = URLSessionConfiguration.default
        let session = URLSession.shared
        
        print(urlRequest)
        
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in

            guard error == nil else {
                print("Error while fetching image data: \(error!)")
                completion(nil)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                completion(nil)
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(ELRelatedTopics.self, from: responseData)
                let characterProfiles = decoded.RelatedTopics
                completion(characterProfiles)
                
            } catch {
                print("Error trying to convert the responseData to JSON using DeCodable")
                completion(nil)
                return
            }
        }

        task.resume()
    }
    
//    func fetchImageDataService(_ url: URL, completion: @escaping (UIImage?) -> Void) {
//
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                print("Error downloading image: \(error)")
//                completion(nil)
//            } else {
//                guard (response as? HTTPURLResponse) != nil
//                    else {
//                        print("No response on image download")
//                        completion(nil)
//                        return
//                }
//
//                if let data = data,
//                    let image = UIImage(data: data) {
//                    completion(image)
//                } else {
//                    completion(nil)
//                }
//            }
//        }
//        task.resume()
//    }
    
}
