//
//  BookDetailView.swift
//  XHBooks
//
//  Created by 李丝思 on 16/5/1.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

class BookDetailView: UIView {
    
    var VIEW_WIDTH: CGFloat!
    
   
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context,0.5)
        CGContextSetRGBFillColor(context,231/255,231/255,231/255,1)
        CGContextMoveToPoint(context,8,SCREEN_HEIGHT-2)
        
    
    }
  

}
