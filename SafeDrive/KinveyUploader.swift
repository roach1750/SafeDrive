//
//  KinveyUploader.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/20/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class KinveyUploader: NSObject {

    func createAndUploadSettingForChildEmailAdress(childsEmailAddress: String) {
        let setting = Setting()
        setting.childUserName = childsEmailAddress
        setting.parentUserName = KCSUser.activeUser().username
        setting.cofirmedLink = NSNumber(bool: false)
        setting.childFirstName = ""
        setting.childLastName = ""
        setting.metadata = KCSMetadata()
        setting.metadata?.setGloballyReadable(true)
        setting.metadata?.setGloballyWritable(true)
        
        let collection = KCSCollection(fromString: "Setting", ofClass: Setting.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        
        store.saveObject(
            setting,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    print("Save failed, with error: %@", errorOrNil.localizedFailureReason)
                } else {
                    print("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                }
            },
            withProgressBlock: nil
        )
    }
    
    func uploadSetting(setting: Setting) {
        let collection = KCSCollection(fromString: "Setting", ofClass: Setting.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        
        store.saveObject(
            setting,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    print("Save failed, with error: %@", errorOrNil.localizedFailureReason)
                } else {
                    print("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                }
            },
            withProgressBlock: nil
        )
        
    }
    
    
    
    
    
    
    
    
    
}
