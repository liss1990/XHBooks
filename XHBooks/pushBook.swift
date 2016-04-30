//
//  pushBook.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/27.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

class pushBook: NSObject {
    
    static func pushBookInBack(dic:NSDictionary)
    {
        let object = AVObject(className: "Book")
        object.setObject(dic["BookName"], forKey: "BookName")
        object.setObject(dic["BookEdior"], forKey: "BookEdior")
        object.setObject(dic["title"], forKey: "title")
        object.setObject(dic["score"], forKey: "score")
        object.setObject(dic["type"], forKey: "type")
        object.setObject(dic["detaileType"], forKey: "detaileType")
        object.setObject(dic["description"], forKey: "description")
        object.setObject(AVUser.currentUser() , forKey: "user")
        
        let image = dic["BookCover"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(image!))
        coverFile.saveInBackgroundWithBlock { (success, error) in
            if success
            {
                object.setObject(coverFile, forKey: "cover")
                object.saveInBackgroundWithBlock({ (success, error)->Void in
                    if success
                    {
                        NSNotificationCenter.defaultCenter().postNotificationName("pushNewViewControllerNotif", object: nil, userInfo:[ "success":"true"])
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("pushNewViewControllerNotif", object: nil, userInfo:[ "success":"false"])
                    }
                })
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("pushNewViewControllerNotif", object: nil, userInfo:[ "success":"false"])
            }
            
        }
    
    }

}
