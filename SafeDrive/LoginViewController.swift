//
//  ViewController.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/19/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        disableLoginButton()
        emailTextField.text = "parent@gmail.com"
//        emailTextField.text = "child@gmail.com"
        passwordTextField.text = "password"
        self.loginButtonPressed(UIButton())
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.loginSuccess), name: LOGINSUCCESSNOTIFICATION, object: nil)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: LOGINSUCCESSNOTIFICATION, object: nil)
    }
    
    func disableLoginButton(){
        loginButton.enabled = false
        loginButton.alpha = 0.3
    }
    
    func enableLoginButton(){
        loginButton.enabled = true
        loginButton.alpha = 1.0
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        if string == " "{
            return false
        }
        if emailTextField.text?.characters.count > 0 && passwordTextField.text?.characters.count >= 5{
            enableLoginButton()
            return true
        }
        if passwordTextField.text?.characters.count < 6 {
            disableLoginButton()
            return true
        }
            
        else {
            return true
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextField && textField.text != "" {
            passwordTextField.becomeFirstResponder()
            return true
        }
        else if textField == passwordTextField && textField.text != "" {
            if loginButton.enabled {
                passwordTextField.resignFirstResponder()
                loginButtonPressed(UIButton())
            }
        }
        return false
    }
    
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        let KUI = KinveyUserInteractor()
        KUI.loginWithUserNameAndPassword(emailTextField.text, password: passwordTextField.text)
    }

    @IBAction func createAccountButtonPressed(sender: UIButton) {
        
    }

    
    func loginSuccess() {
        
        let userType = KCSUser.activeUser().getValueForAttribute(USERTYPEKEY) as! String
        if userType == USERTYPECHILD {
            performSegueWithIdentifier("startAsChild", sender: self)
        }
        else if userType == USERTYPEPARENT {
            performSegueWithIdentifier("startAsParent", sender: self)
        }
    }
    
    
}

