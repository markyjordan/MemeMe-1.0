//
//  MemeTextFieldsDelegate.swift
//  MemeMe 1.0
//
//  Created by Marky Jordan on 4/19/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import Foundation
import UIKit

// MARK: MemeTextFieldsDelegate: NSObject, UITextFieldDelegate

class MemeTextFieldsDelegate: NSObject, UITextFieldDelegate {

    let defaultText: [String: String] = [
        
        "top": "TAP TO EDIT TOP TEXT",
        "bottom": "TAP TO EDIT BOTTOM TEXT"
    ]
    
    // MARK: UITextFieldDelegate Methods
    
    // clear the default text when user taps the text field to begin editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == defaultText["top"] || textField.text == defaultText["bottom"] {
            textField.text = ""
        }
    }
    
    // dismiss the keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
