//
//  push_DetillViewController.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/22.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

typealias push_DetillViewControllerBlock=(description:String)->Void

class push_DetillViewController: UIViewController {

    var textView : FloatLabelTextView?
    var callBack : push_DetillViewControllerBlock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.textView = FloatLabelTextView(frame: CGRectMake(8, 50, SCREEN_WIDTH-16, 300))
        self.view.addSubview(self.textView!)
        self.textView?.font = UIFont(name: MA_FOUT, size: 17)
        self.view.tintColor = UIColor.grayColor()
        self.textView?.becomeFirstResponder()
        self.textView?.hint = "     输入字书评"
        
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
        self.callBack!(description:(self.textView?.text)!)
        self.dismissViewControllerAnimated(true) { 
            
        }
        
    }

}
