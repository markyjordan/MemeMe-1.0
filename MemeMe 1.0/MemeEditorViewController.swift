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
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // MARK: Properties
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor(white: 0.0, alpha: 1.0),
        NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 1.0),
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: NSNumber(3.0)
    ]
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set textAlignment property of textfields to center
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
        // set default text in textfields
        topTextField.text = "Top"
        bottomTextField.text = "Bottom"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // check if camera is available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
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
    
    // MARK: UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            
            // set photoImageView to display the selected image
            photoImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

