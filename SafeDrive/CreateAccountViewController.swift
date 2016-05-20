//
//  CreateAccountViewController.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/19/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableCreateAccountButton()
    }
    
    func disableCreateAccountButton(){
        createAccountButton.enabled = false
        createAccountButton.alpha = 0.3
    }
    
    func enableCreateAccountButton(){
        createAccountButton.enabled = true
        createAccountButton.alpha = 1.0
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        //
        //        print("First Name Text Field has \(firstNameTextField.text!.characters.count) characters")
        //        print("Last Name Text Field has \(lastNameTextField.text!.characters.count) characters")
        //        print("Email Text Field has \(emailTextField.text!.characters.count) characters")
        //        print("Password Text Field has \(passwordTextField.text!.characters.count) characters")
        //        print("String is: \(string)")
        //        print("Range is: \(range)")
        //        print("\n")
        //
        
        if string == " "{
            return false
        }
        if string.characters.count == 0 && range.location == 0 {
            print("Delete Key Pressed")
            disableCreateAccountButton()
        }
        
        if emailTextField.text?.characters.count > 1 && passwordTextField.text?.characters.count > 6 && firstNameTextField.text?.characters.count > 1 && lastNameTextField.text?.characters.count > 1{
            enableCreateAccountButton()
        }
        
        return true
        
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTextFieldTag = textField.tag + 1
        if nextTextFieldTag != 5 {
            let nextTextField = self.view.viewWithTag(nextTextFieldTag) as! UITextField
            nextTextField.becomeFirstResponder()
        }
        if nextTextFieldTag == 5 && createAccountButton.enabled == true{
            self.createAccountButtonPressed(UIButton())
        }
        return false
    }
    
    
    @IBAction func createAccountButtonPressed(sender: UIButton) {
        let userType: String
        if userTypeSegmentedControl.selectedSegmentIndex == 0 {
            userType = USERTYPECHILD
        }
        else {
            userType = USERTYPEPARENT
        }
        let userProperties = [USEREMAILKEY : emailTextField.text, USERPASSWORDKEY : passwordTextField.text, USERFIRSTNAMEKEY: firstNameTextField.text, USERLASTNAMEKEY: lastNameTextField.text, USERTYPEKEY : userType]
        
        let kUI = KinveyUserInteractor()
        kUI.createUserWithProperties(userProperties)
    }
    
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
