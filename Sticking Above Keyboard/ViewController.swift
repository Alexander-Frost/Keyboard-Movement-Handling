//
//  ViewController.swift
//  Sticking Above Keyboard
//
//  Created by Alex on 4/14/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let btn: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!

    @IBOutlet weak var myTextfield: UITextField!
    
    @IBOutlet weak var myTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var myBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // uncomment to use input view
        // set custom auto word suggestion using this
//        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
//        customView.backgroundColor = UIColor.red
//        myTextfield.inputAccessoryView = customView
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    
        
        myBtn.backgroundColor = UIColor.green
        myBtn.setTitle("Click Me", for: .normal)
    }


    
    @objc func handleKeyboardNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            // if keyboard is showing then increase padding / decrease when hiding
            if notification.name == UIResponder.keyboardWillShowNotification{
                myTopConstraint?.constant = -keyboardFrame!.height
            } else {
                myTopConstraint?.constant =  +keyboardFrame!.height
            }
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
