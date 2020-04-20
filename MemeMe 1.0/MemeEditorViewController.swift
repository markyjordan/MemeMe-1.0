//
//  MemeEditorViewController.swift
//  MemeMe 1.0
//
//  Created by Marky Jordan on 3/18/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import Foundation
import UIKit

// MARK: MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromAlbum(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
        
        // set the delegate(s)
        imagePickerVC.delegate = self
        
        // specify sourceType
        imagePickerVC.sourceType = .photoLibrary
        
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromCamera(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
        
        // set the delegate(s)
        imagePickerVC.delegate = self
        
        // specify sourceType
        imagePickerVC.sourceType = .camera
        
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    // implement the UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            
            // set photoImageView to display the selected image
            photoImageView.image = selectedImage
        }
        // dismiss the picker
        dismiss(animated: true, completion: nil )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // dismiss the picker upon user cancellation
        dismiss(animated: true, completion: nil)
    }

}

