//
//  ELNetworkManager.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/19/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation
import UIKit

class ELNetworkManager {
    
    func requestCharachers(completion: @escaping (ELCharacterProfilelPlusImageDataArray?) -> Void) {
        
        ELFetchServices().fetchDuckDuckGoCharachtersService {[weak self] (characterProfiles) in
            
            if let characterProfiles = characterProfiles {
                self?.requestImageDataForProfiles(characterProfiles, completion: { (imagesArray) in
                    completion(imagesArray)
                })
            } else {
                completion(nil)
            }
        }
    }
    
    private func requestImageDataForProfiles(_ profileArray: ELCharacterProfileArray, completion: @escaping(_ profileImages: ELCharacterProfilelPlusImageDataArray) -> Void) {

        var imagesArray = ELCharacterProfilelPlusImageDataArray()
        imagesArray.reserveCapacity(profileArray.count)
        var nonImageArray = ELCharacterProfilelPlusImageDataArray()
        nonImageArray.reserveCapacity(profileArray.count)

        let downloadGroup = DispatchGroup()
        let queue = DispatchQueue(label: "requestImageData")

        for profile in profileArray {

            if let httpUrl = URL(string: profile.iconURL) {
                queue.async(group:downloadGroup) {
                    downloadGroup.enter()
                    ELFetchServices().fetchImageDataService(httpUrl, completion: { (image) in
                        
                        let fetchQueue = DispatchQueue(label: "fetchQueue")
                        fetchQueue.sync {
                            if let image = image {
                                imagesArray.append(ELCharacterProfilelPlusImageData(profile: profile, image: image))
                            }
                        }
                        downloadGroup.leave()
                    })
                }
            } else {
                let image = UIImage(named:"selfie.png")
                nonImageArray.append(ELCharacterProfilelPlusImageData(profile: profile, image: image))
            }
        }

        downloadGroup.notify(queue: queue) {
            completion(imagesArray + nonImageArray)
        }
    }
    
}
