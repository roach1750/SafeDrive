//
//  KinveyDownloader.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/20/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class KinveyDownloader: NSObject {
    
    var downloadedSettings: [Setting]?
    
    func fetchSettingsAsParent(){
        let parentEmail = KCSUser.activeUser().username
        let query = KCSQuery(onField: PARENTUSERNAMEKEY, withExactMatchForValue: parentEmail)
        let collection = KCSCollection(fromString: "Setting", ofClass: Setting.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        
        store.queryWithQuery(
            query,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil == nil {
                    if objectsOrNil.count > 0 {
                    self.downloadedSettings = objectsOrNil as? [Setting]
                    NSNotificationCenter.defaultCenter().postNotificationName(SETTINGSDOWNLOADEDNOTIFICATION, object: self)
                    }
                } else {
                    print("No Settings Found")
                }
            },
            withProgressBlock: nil
        )
    }
    
    func fetchSettingForChild(childEmail:String) {
        let query = KCSQuery(onField: CHILDUSERNAMEKEY, withExactMatchForValue: childEmail)
        let collection = KCSCollection(fromString: "Setting", ofClass: Setting.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        
        store.queryWithQuery(
            query,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil == nil {
                    if objectsOrNil.count > 0 {
                        self.downloadedSettings = objectsOrNil as? [Setting]
                        NSNotificationCenter.defaultCenter().postNotificationName(SETTINGSDOWNLOADEDNOTIFICATION, object: self)
                    }
                } else {
                    print("No Settings Found")
                }
            },
            withProgressBlock: nil
        )
    }
    
}
