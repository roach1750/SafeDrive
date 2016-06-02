//
//  Test.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/21/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class Test: NSObject {

    var entityId: String?
    var childUserName: String?
    var childFirstName: String?
    var childLastName: String?
    var parentUserName: String?
    var location: CLLocation?
    var pass: NSNumber?
    var bacResult: NSNumber?
    var metadata: KCSMetadata?
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId,
            "childUserName" : CHILDUSERNAMEKEY,
            "childFirstName" : CHILDFIRSTNAMEKEY,
            "childLastName" : CHILDLASTNAMEKEY,
            "parentUserName" : PARENTUSERNAMEKEY,
            "location" : TESTLOCATIONKEY,
            "pass" : TESTPASSORFAIL,
            "bacResult" : TESTBACRESULT,
            "metadata" : KCSEntityKeyMetadata
        ]
    }
}
