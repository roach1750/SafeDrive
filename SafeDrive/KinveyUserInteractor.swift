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
                    //the log-in was successful and the user is now the active user and credentials saved
                    //hide log-in view and show main app content
                } else {
                    //there was an error with the update save
                    let message = errorOrNil.localizedDescription
                    print(message)
                }
            })
    }
    
    func createUserWithProperties(userAttributes: Dictionary <String, String?>){
        KCSUser.userWithUsername(
            "kinvey",
            password: "12345",
            fieldsAndValues: [
                KCSUserAttributeEmail : "kinvey@kinvey.com",
                KCSUserAttributeGivenname : "Arnold",
                KCSUserAttributeSurname : "Kinvey",
                "User Type" : "Parent"
            ],
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //user is created
                } else {
                    //there was an error with the create
                }
            }
        )
    }
    
    
}
