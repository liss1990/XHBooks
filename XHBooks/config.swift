//
//  config.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/18.
//  Copyright © 2016年 思. All rights reserved.
//

import Foundation

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
let MAIN_RED = UIColor(colorLiteralRed: 235/255, green: 114/255, blue: 118/255, alpha: 1)
let MA_FOUT="Bauhaus ITC"

func RGB(r:Float,g:Float,b:Float) -> UIColor {
    return UIColor(colorLiteralRed: r/255.0,green:g/255.0,blue:b/255.0,alpha:1 )
}