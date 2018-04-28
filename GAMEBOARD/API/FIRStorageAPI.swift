//
//  FIRStorageAPI.swift
//  GAMEBOARD
//
//  Created by T on 4/28/18.
//  Copyright © 2018 T. All rights reserved.
//

import Foundation
import FirebaseStorage
//import SVProgressHUD


class FIRStorageAPI: NSObject {
    let storageRef = Storage.storage().reference()

    
    func uploadDataToStorage (data: Data,itemStoragePath: String, contentType: String?, completion: ((StorageMetadata?, Error?) -> Void)?) {
        
        let metadata = StorageMetadata()
        metadata.contentType = contentType
        
        storageRef.child(itemStoragePath).putData(data, metadata: metadata, completion: completion)
        
        
    }
    // Upload HeadImage with DetailImages
    
}

