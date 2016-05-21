//
//  Setting.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/20/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class Setting: NSObject {
    
    var entityId: String?
    var childUserName: String?
    var childFirstName: String?
    var childLastName: String?
    var parentUserName: String?
    var cofirmedLink: NSNumber?
    var metadata: KCSMetadata?
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId,
            "childUserName" : CHILDUSERNAMEKEY,
            "childFirstName" : CHILDFIRSTNAMEKEY,
            "childLastName" : CHILDLASTNAMEKEY,
            "parentUserName" : PARENTUSERNAMEKEY,
            "cofirmedLink" : CONFIRMEDLINKKEY,
            "metadata" : KCSEntityKeyMetadata
        ]
    }

}
