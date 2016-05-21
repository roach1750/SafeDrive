//
//  KinveyUserInteractor.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/19/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import Foundation

class KinveyUserInteractor: NSObject {

    
    func loginWithUserNameAndPassword(email:String?, password:String?){
        KCSUser.loginWithUsername(
            email,
            password: password,
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    NSNotificationCenter.defaultCenter().postNotificationName(LOGINSUCCESSNOTIFICATION, object: self)                
                    
                } else {
                    //there was an error with the update save
                    let message = errorOrNil.localizedDescription
                    print(message)
                }
            })
    }
    
    func createUserWithProperties(userAttributes: Dictionary <String, String?>){
        let firstName = userAttributes[USERFIRSTNAMEKEY]!
        let lastName = userAttributes[USERLASTNAMEKEY]!
        let email = userAttributes[USEREMAILKEY]!
        let password = userAttributes[USERPASSWORDKEY]!
        let userType = userAttributes[USERTYPEKEY]!
    
        
        KCSUser.userWithUsername(
            email,
            password: password,
            fieldsAndValues: [
                KCSUserAttributeEmail : email!,
                KCSUserAttributeGivenname : firstName!,
                KCSUserAttributeSurname : lastName!,
                "User Type" : userType!
            ],
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //user is created
                    NSNotificationCenter.defaultCenter().postNotificationName(LOGINSUCCESSNOTIFICATION, object: self)
                } else {
                    print(errorOrNil)
                    //there was an error with the create
                }
            }
        )
    }
    
    
}
