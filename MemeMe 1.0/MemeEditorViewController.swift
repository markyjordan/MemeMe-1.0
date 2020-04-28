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
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // MARK: Properties
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        
        NSAttributedString.Key.strokeColor: UIColor(white: 0.0, alpha: 1.0), // UIColor = black
        NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 1.0), // UIColor = white
        NSAttributedString.Key.font: UIFont(name: "Impact", size: 40)!,
        NSAttributedString.Key.strokeWidth: NSNumber(5.0)
    ]
    
    // MARK: Text Field Delegate Objects
    
    let memeTextFieldDelegate = MemeTextFieldsDelegate()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // set the delegates
        self.topTextField.delegate = memeTextFieldDelegate
        self.bottomTextField.delegate = memeTextFieldDelegate
        
        // set default text in textfields
        topTextField.text = "TAP TO EDIT TOP"
        bottomTextField.text = "TAP TO EDIT BOTTOM"
        
        // set default text attributes
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        // set textAlignment property of textfields to center
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // check if camera is available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // subscribe to keyboard notifications
        subscribeToKeyboardWillShowNotifications()
        subscribeToKeyboardWillHideNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // unsubsribe from keyboard notifications
        unsubscribeFromKeyboardWillShowNotifications()
        unsubscribeFromKeyboardWillHideNotifications()
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
    
    // MARK: NSNotification Functions
    
    // observers
    func subscribeToKeyboardWillShowNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardWillShowNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardWillHideNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // implement functions to act on notifications
    @objc func keyboardWillShow(_ notification: Notification) {
        
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification: Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func generateMemedImage() -> UIImage {

        // hide toolbar and navigation bar
        navigationBar.isHidden = true
        toolBar.isHidden = true
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // show toolbar and navigation bar
        navigationBar.isHidden = false
        toolBar.isHidden = false

        return memedImage
    }
}
