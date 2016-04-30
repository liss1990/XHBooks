//
//  BookTitleView.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/19.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit
@objc protocol BookTitleDelegate{
    optional func choicCover()
}

class BookTitleView: UIView {

    var BookCover:UIButton?
    var BookName:FloatLabelTextField?
    var BookEditor:FloatLabelTextField?
    weak var delegate : BookTitleDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.BookCover = UIButton(frame: CGRectMake(10,0,110,141))
        self.BookCover?.setImage(UIImage(named: "bookPage.jpg"), forState: .Normal)
        self.addSubview(self.BookCover!)
        
        self.BookCover?.addTarget(self, action: #selector(BookTitleDelegate.choicCover), forControlEvents: .TouchUpInside)
        
        self.BookName = FloatLabelTextField(frame:CGRectMake(128, 8+20, SCREEN_WIDTH-128-15, 30))
        self.BookEditor = FloatLabelTextField(frame: CGRectMake(128, 8+20+70, SCREEN_WIDTH-128-15, 30))
        self.BookName?.placeholder = "书名"
        self.BookEditor?.placeholder = "作者"
        self.BookName?.titleFont = UIFont(name: MA_FOUT, size: 14)!
        self.BookEditor?.titleFont = UIFont(name: MA_FOUT, size: 14)!
        
        self.BookName?.font = UIFont(name: MA_FOUT, size: 14)
        self.BookEditor?.font = UIFont(name: MA_FOUT, size: 14)
        
        self.addSubview(self.BookName!)
        self.addSubview(self.BookEditor!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemteted")
    }
    
    func choicCover() {
        self.delegate?.choicCover!()
    }
    

}
