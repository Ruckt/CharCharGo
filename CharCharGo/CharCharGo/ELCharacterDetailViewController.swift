//
//  ELCharacterDetailViewController.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/18/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import UIKit

class ELCharacterDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    var characterProfile: ELCharacterProfilelPlusImageData?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        if let description = characterProfile?.profile.description,
            let label = detailDescriptionLabel {
                label.text = description
        }
        
        if let characterImage = characterProfile?.image {
            characterImageView.image = characterImage
        }
        
        if let name = characterProfile?.profile.name {
            self.title = name
        }
    }
}
