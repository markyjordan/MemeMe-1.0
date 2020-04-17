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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: Actions
    
    //
    @IBAction func selectImage(_ sender: Any) {
        let imageSelectorVC = UINavigationController()
        imageSelectorVC.delegate = self
        present(imageSelectorVC, animated: true, completion: nil)
    }
    
    // implement the UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

