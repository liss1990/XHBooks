//
//  push_TypeViewController.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/22.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

typealias push_TypeViewControllerBlock = (type:String,detailType:String)->Void

class push_TypeViewController: UIViewController ,IGLDropDownMenuDelegate{

    var segmentController1:AKSegmentedControl?
    var segmentController2:AKSegmentedControl?
    
    var literatureArray1:Array<NSDictionary>=[]
    var literatureArray2:Array<NSDictionary>=[]
    
    var humanitiesArray1:Array<NSDictionary>=[]
    var humanitiesArray2:Array<NSDictionary>=[]
    
    var liveihoodArray1:Array<NSDictionary>=[]
    var liveihoodArray2:Array<NSDictionary>=[]
    
    var technologyArray1:Array<NSDictionary>=[]
    var technologyArray2:Array<NSDictionary>=[]
    
    var economiesArray1:Array<NSDictionary>=[]
    var economiesArray2:Array<NSDictionary>=[]
    
    var otherArray1:Array<NSDictionary>=[]
    var otherArray2:Array<NSDictionary>=[]
    
    var dropDownMenu1:IGLDropDownMenu?
    var dropDownMenu2:IGLDropDownMenu?
    
    var  type = "文学"
    var detailType = "文学"
    
    var callBack : push_TypeViewControllerBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(231, g: 231, b: 231)
        
        let segmentLabel = UILabel(frame: CGRectMake((SCREEN_WIDTH-300)/2,20,300,20))
        segmentLabel.text = "请选择分类"
        segmentLabel.font = UIFont(name: MA_FOUT, size: 17)
        segmentLabel.shadowOffset = CGSizeMake(0, 1)
        segmentLabel.shadowColor = UIColor.whiteColor()
        segmentLabel.textColor = RGB(82, g: 113, b: 131)
        segmentLabel.textAlignment = .Center
        self.view.addSubview(segmentLabel)
        segmentController1 = AKSegmentedControl(frame: CGRectMake(10,CGRectGetMaxY(segmentLabel.frame)+20,SCREEN_WIDTH-20,35))
        segmentController2 = AKSegmentedControl(frame: CGRectMake(10,CGRectGetMaxY(segmentLabel.frame)+20+40,SCREEN_WIDTH-20,35))
        
        segmentController1?.addTarget(self, action: #selector(push_TypeViewController.segmentedViewController(_:)), forControlEvents: UIControlEvents.ValueChanged)
        segmentController1?.segmentedControlMode = AKSegmentedControlMode.Sticky
        segmentController1?.setSelectedIndex(3)
        
        segmentController2?.addTarget(self, action: #selector(push_TypeViewController.segmentedViewController(_:)), forControlEvents: UIControlEvents.ValueChanged)
        segmentController2?.segmentedControlMode = AKSegmentedControlMode.Sticky
        segmentController2?.setSelectedIndex(3)
        
        self.initDropArray()
        self.initsegment1()
        self.creatDropMenu(self.literatureArray1, array2:self.literatureArray2)
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
        self.callBack!(type:self.type,detailType: self.detailType)
        self.dismissViewControllerAnimated(true) { 
            
        }
        
    }
    /**
     *  初始化segment
     */
    
    func initsegment1() {
        
        segmentController1?.backgroundImage = UIImage(named: "segmented-bg")?.resizableImageWithCapInsets(UIEdgeInsetsMake(10, 10, 10, 10))
        segmentController2?.backgroundImage = UIImage(named: "segmented-bg")?.resizableImageWithCapInsets(UIEdgeInsetsMake(10, 10, 10, 10))
        let buttonBackgroundImagePressedLeft = UIImage (named:"segmented-bg-pressed-left.png")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0))
        let buttonBackgroundImagePressedCenter = UIImage (named:"segmented-bg-pressed-center.png")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0))
        let buttonBackgroundImagePressedRight = UIImage (named:"segmented-bg-pressed-right.png")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0))
        
        let btnSocialImageNormal = UIImage(named: "social-icon")
        let btn1 = UIButton(type: .Custom)
        btn1.titleLabel?.font = UIFont(name: MA_FOUT, size: 13)
        btn1 .setTitle("文学", forState: .Normal)
        btn1.setBackgroundImage(buttonBackgroundImagePressedLeft, forState: .Highlighted)
        btn1.setBackgroundImage(buttonBackgroundImagePressedLeft, forState: .Selected)
        btn1.setImage(btnSocialImageNormal, forState: .Normal)
        btn1.setImage(btnSocialImageNormal, forState: .Highlighted)
        btn1.setImage(btnSocialImageNormal, forState: .Selected)
        btn1.setTitleColor(RGB(82, g: 113, b: 131), forState: .Normal)
        
        let btn2ImageNormal = UIImage(named: "star-icon")
        let btn2 = UIButton(type: .Custom)
        btn2.setTitle("人文社科", forState: .Normal)
        btn2.titleLabel?.font = UIFont(name: MA_FOUT, size: 13)
        btn2.setTitleColor(RGB(82, g: 113, b: 131), forState: .Normal)
        btn2.setBackgroundImage(buttonBackgroundImagePressedCenter, forState: .Highlighted)
        btn2.setBackgroundImage(buttonBackgroundImagePressedCenter, forState: .Selected)
        btn2.setImage(btn2ImageNormal, forState: .Normal)
        btn2.setImage(btn2ImageNormal, forState: .Highlighted)
        btn2.setImage(btn2ImageNormal, forState: .Selected)
        
        let btn3ImageNormal = UIImage(named: "star-icon")
        let btn3 = UIButton(type: .Custom)
        btn3.setTitle("生活", forState: .Normal)
        btn3.titleLabel?.font = UIFont(name: MA_FOUT, size: 13)
        btn3.setImage(btn3ImageNormal, forState: .Normal)
        btn3.setImage(btn3ImageNormal, forState: .Highlighted)
        btn3.setImage(btn3ImageNormal, forState: .Selected)
        btn3.setBackgroundImage(buttonBackgroundImagePressedRight, forState: .Highlighted)
        btn3.setBackgroundImage(buttonBackgroundImagePressedRight, forState: .Selected)
        btn3.setTitleColor(RGB(82, g: 113, b: 131), forState: .Normal)
        
        segmentController1?.buttonsArray = [btn1,btn2,btn3]
        self.view.addSubview(segmentController1!)
        
        let btnSocialImageNormal2 = UIImage(named: "social-icon")
        let segmentbtn2 = UIButton(type: .Custom)
        segmentbtn2.titleLabel?.font = UIFont(name: MA_FOUT, size: 13)
        segmentbtn2 .setTitle("经管", forState: .Normal)
        segmentbtn2.setBackgroundImage(buttonBackgroundImagePressedLeft, forState: .Highlighted)
        segmentbtn2.setBackgroundImage(buttonBackgroundImagePressedLeft, forState: .Selected)
        segmentbtn2.setImage(btnSocialImageNormal2, forState: .Normal)
        segmentbtn2.setImage(btnSocialImageNormal2, forState: .Highlighted)
        segmentbtn2.setImage(btnSocialImageNormal2, forState: .Selected)
        segmentbtn2.setTitleColor(RGB(82, g: 113, b: 131), forState: .Normal)
        
        let btn2ImageNormal2 = UIImage(named: "star-icon")
        let segmentbtn3 = UIButton(type: .Custom)
        segmentbtn3.setTitle("科技", forState: .Normal)
        segmentbtn3.titleLabel?.font = UIFont(name: MA_FOUT, size: 13)
        segmentbtn3.setTitleColor(RGB(82, g: 113, b: 131), forState: .Normal)
        segmentbtn3.setBackgroundImage(buttonBackgroundImagePressedCenter, forState: .Highlighted)
        segmentbtn3.setBackgroundImage(buttonBackgroundImagePressedCenter, forState: .Selected)
        segmentbtn3.setImage(btn2ImageNormal2, forState: .Normal)
        segmentbtn3.setImage(btn2ImageNormal2, forState: .Highlighted)
        segmentbtn3.setImage(btn2ImageNormal2, forState: .Selected)
        
        let btn3ImageNormal2 = UIImage(named: "star-icon")
        let segmentBtn4 = UIButton(type: .Custom)
        segmentBtn4.setTitle("网络流行", forState: .Normal)
        segmentBtn4.titleLabel?.font = UIFont(name: MA_FOUT, size: 13)
        segmentBtn4.setImage(btn3ImageNormal2, forState: .Normal)
        segmentBtn4.setImage(btn3ImageNormal2, forState: .Highlighted)
        segmentBtn4.setImage(btn3ImageNormal2, forState: .Selected)
        segmentBtn4.setBackgroundImage(buttonBackgroundImagePressedRight, forState: .Highlighted)
        segmentBtn4.setBackgroundImage(buttonBackgroundImagePressedRight, forState: .Selected)
        segmentBtn4.setTitleColor(RGB(82, g: 113, b: 131), forState: .Normal)
        
        segmentController2?.buttonsArray = [segmentbtn2,segmentbtn3,segmentBtn4]
        self.view.addSubview(segmentController2!)
        
    }
    /**
     选项卡
     - parameter segment:  
     */
    func segmentedViewController(segment: AKSegmentedControl)  {
        var index = segment.selectedIndexes.firstIndex
        self.type=((segment.buttonsArray[index] as? UIButton)?.currentTitle)!
        
        
        if segment == self.segmentController1 {
            self.segmentController2?.setSelectedIndex(3)
        }else{
            self.segmentController1?.setSelectedIndex(3)
            index+=3
        }
        
        if self.dropDownMenu1 != nil
        {
            self.dropDownMenu1?.resetParams()
        }
        if self.dropDownMenu2 != nil {
            self.dropDownMenu2?.resetParams()
        }
        
        switch index {
        case 0:
            self.creatDropMenu(self.literatureArray1, array2: literatureArray2)
            break
        case 1:
             self.creatDropMenu(self.humanitiesArray1, array2: humanitiesArray2)
            break
        case 2:
             self.creatDropMenu(self.liveihoodArray1, array2: liveihoodArray2)
            break
        case 3:
             self.creatDropMenu(self.economiesArray1, array2: economiesArray2)
            break
        case 4:
             self.creatDropMenu(self.technologyArray1, array2: technologyArray2)
            break
        case 5:
             self.creatDropMenu(self.otherArray1 , array2: otherArray2)
            break
        default:
            break
        }
        
    }
    /**
     初始化dropdownMenu
     
     - returns:
     */
    func creatDropMenu(array1:Array<NSDictionary>,array2:Array<NSDictionary>)  {
        let dropDownItem1 = NSMutableArray()
        for i in 0  ..< array1.count {
            let dict  =  array1[i]
            let iten  = IGLDropDownItem()
            iten.text = dict["title"] as? String
            dropDownItem1.addObject(iten)
            
        }
        let dropDownItem2 = NSMutableArray()
        for i in 0  ..< array2.count {
            let dict  =  array2[i]
            let iten  = IGLDropDownItem()
            iten.text = dict["title"] as? String
            dropDownItem2.addObject(iten)
        }
        
        self.dropDownMenu1?.removeFromSuperview()
        self.dropDownMenu1 = IGLDropDownMenu()
        self.dropDownMenu1?.menuText = "展开详细列表"
        self.dropDownMenu1?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        self.dropDownMenu1?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        self.dropDownMenu1?.paddingLeft = 10
        self.dropDownMenu1?.delegate = self
        self.dropDownMenu1?.type = .SlidingInBoth
        self.dropDownMenu1?.itemAnimationDelay = 0.1
        self.dropDownMenu1?.gutterY = 5
        self.dropDownMenu1?.dropDownItems = dropDownItem1 as [AnyObject]
        self.dropDownMenu1?.frame = CGRectMake(20, 150, SCREEN_WIDTH/2-20, (SCREEN_HEIGHT-200)/7)
        self.view.addSubview(self.dropDownMenu1!)
        self.dropDownMenu1?.reloadView()
        
        self.dropDownMenu2?.removeFromSuperview()
        self.dropDownMenu2 = IGLDropDownMenu()
        self.dropDownMenu2?.menuText = "展开详细列表"
        self.dropDownMenu2?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        self.dropDownMenu2?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        self.dropDownMenu2?.paddingLeft = 10
        self.dropDownMenu2?.delegate = self
        self.dropDownMenu2?.type = .SlidingInBoth
        self.dropDownMenu2?.itemAnimationDelay = 0.1
        self.dropDownMenu2?.gutterY = 5
        self.dropDownMenu2?.dropDownItems = dropDownItem2 as [AnyObject]
        self.dropDownMenu2?.frame = CGRectMake(SCREEN_WIDTH/2+10 , 150, SCREEN_WIDTH/2-20, (SCREEN_HEIGHT-200)/7)
        self.view.addSubview(self.dropDownMenu2!)
        self.dropDownMenu2?.reloadView()
    }
    
    /**
     IGLdropmenudelegate
     
     - returns:
     */
    func dropDownMenu(dropDownMenu: IGLDropDownMenu!, selectedItemAtIndex index: Int) {
       
        if dropDownMenu == self.dropDownMenu1{
            let item = self.dropDownMenu1?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu2?.menuButton.text = self.detailType
        }else
        {
            let item = self.dropDownMenu2?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu1?.menuButton.text = self.detailType
        }
        
    }
    
    func initDropArray() {
        
        self.literatureArray1 = [
            ["title":"小说"],
            ["title":"漫画"],
            ["title":"青春文学"],
            ["title":"随笔"],
            ["title":"现当代诗"],
            ["title":"戏剧"]
        ]
        self.literatureArray2 = [
            ["title":"传记"],
            ["title":"古代词"],
            ["title":"国外诗歌"],
            ["title":"艺术"],
            ["title":"摄影"]
        ]
        self.humanitiesArray1 = [
            ["title":"历史"],
            ["title":"文化"],
            ["title":"古籍"],
            ["title":"心理学"],
            ["title":"哲学/宗教"],
            ["title":"政治/军事"]
        ]
        self.humanitiesArray2 = [
            ["title":"社会科学"],
            ["title":"法律"]
        ]
        self.liveihoodArray1 = [
            ["title":"休闲/爱好"],
            ["title":"孕产/胎教"],
            ["title":"烹饪/美食"],
            ["title":"时尚/美妆"],
            ["title":"旅游/地图"],
            ["title":"家庭/家居"]
        ]
        self.liveihoodArray2 = [
            ["title":"亲子/家教"],
            ["title":"两性关系"],
            ["title":"育儿/早教"],
            ["title":"保健/养生"],
            ["title":"体育/运动"],
            ["title":"手工/DIY"]
        ]
        self.technologyArray1 = [
            ["title":"篮球"],
            ["title":"足球"],
            ["title":"乒乓球"],
            ["title":"高尔夫"]
        ]
        self.technologyArray2 = [
            ["title":"NBA"],
            ["title":"CBA"],
            ["title":"MBA"],
            ["title":"WNBA"]
        ]
        self.economiesArray1 = [
            ["title":"火星人"],
            ["title":"外星人"],
            ["title":"地球人"],
            ["title":"月球人"],
            ["title":"水星人"],
            ["title":"土星人"]
        ]
        self.economiesArray2 = [
            ["title":"好人"],
            ["title":"坏人"],
            ["title":"不是人"]
        ]
        self.otherArray1 = [
            ["title":"衣服"],
            ["title":"裤子"],
            ["title":"背心"],
            ["title":"短裤"],
            ["title":"袜子"]
        ]
        self.otherArray2 = [
            ["title":"柴米"],
            ["title":"油盐"],
            ["title":"酱醋"],
            ["title":"茶"]
        ]

    }
    
    
}
