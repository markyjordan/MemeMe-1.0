//
//  Meme.swift
//  MemeMe 1.0
//
//  Created by Marky Jordan on 4/24/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import Foundation

struct Meme {
    var topTextField: String!
    var bottomTextField: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    
    func save() {
        
        // Create the meme
        let meme = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, originalImage: originalImage.image!, memedImage: memedImage)
    }
}
