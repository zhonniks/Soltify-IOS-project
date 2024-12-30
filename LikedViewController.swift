//
//  LikedViewController.swift
//  Soltify
//
//  Created by Альтаир Кабдрахманов on 27.12.2024.
//

import UIKit

class LikedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set background image
        let backgroundImage = UIImage(named: "home") // Replace with your image name
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .topLeft
        imageView.frame = view.bounds
        
        // Add the image view to the view hierarchy
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView) // Send to back so other content appears on top
    }
}
