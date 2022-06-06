//
//  CustomTextField.swift
//  Test
//
//  Created by Apple iQlance on 03/06/2022.
//

import Foundation
import UIKit

@IBDesignable class CustomTextField: UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
         get {
             return self.placeHolderColor
         }
         set {
             self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
         }
     }
}
