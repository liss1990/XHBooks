//
//  push_TitleViewController.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/22.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

typealias Push_TiltleCallBack = (Title:String )->Void


class push_TitleViewController: UIViewController {
    var textField:UITextField?
    
    ////实现回调
    var callBack : Push_TiltleCallBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
       self.textField = UITextField(frame: CGRectMake(15,60 ,SCREEN_WIDTH-30,30))
        self.textField?.borderStyle = .RoundedRect
        self.textField?.placeholder = "书评标题"
        self.textField?.font = UIFont(name: MA_FOUT, size: 15)
        self.view.addSubview(self.textField!)
        self.textField?.becomeFirstResponder()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func close()  {
        self.dismissViewControllerAnimated(true) {
            
        }
    }
    func sure() {
        self.callBack!(Title: (self.textField!.text)!)
        self.dismissViewControllerAnimated(true) { 
            
        }
    }

}
