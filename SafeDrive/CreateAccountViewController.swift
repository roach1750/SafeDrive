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
        if string == " "{
            return false
        }
        if emailTextField.text?.characters.count > 0 && passwordTextField.text?.characters.count >= 5{
            enableCreateAccountButton()
            return true
        }
        if passwordTextField.text?.characters.count < 6 {
            disableCreateAccountButton()
            return true
        }
            
        else {
            return true
        }
        
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
