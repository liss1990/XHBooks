//
//  GeneralFactory.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/18.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

class GeneralFactory: NSObject {
    
    static func addTitleWithTie(target:UIViewController,title1:String="关闭",title2:String = "确认"){
        
        let btn1 = UIButton(frame: CGRectMake(10,20,60,40))
        btn1.setTitle(title1, forState: .Normal)
        btn1.contentHorizontalAlignment = .Center
        btn1.setTitleColor(MAIN_RED, forState: .Normal)
        btn1.titleLabel?.font=UIFont(name: MA_FOUT, size: 14)
        btn1.tag = 123
        target.view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRectMake(SCREEN_WIDTH-70,20,60,40))
        btn2.setTitle(title2, forState: .Normal)
        btn2.contentHorizontalAlignment = .Center
        btn2.setTitleColor(MAIN_RED, forState: .Normal)
        btn2.titleLabel?.font = UIFont(name: MA_FOUT, size: 14)
        target.view.addSubview(btn2)
        btn2.tag = 124
        btn1.addTarget(target, action: Selector("close"), forControlEvents: .TouchUpInside)
        btn2.addTarget(target, action: Selector("sure"), forControlEvents: .TouchUpInside)
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
