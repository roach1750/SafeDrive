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
    var passOrFail: NSNumber?
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
            "passOrFail" : TESTPASSORFAIL,
            "bacResult" : TESTBACRESULT,
            "metadata" : KCSEntityKeyMetadata
        ]
    }
}
