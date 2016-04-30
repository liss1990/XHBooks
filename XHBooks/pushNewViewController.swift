//
//  pushNewViewController.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/18.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

class pushNewViewController: UIViewController,BookTitleDelegate,PhotoPickerDelegate,VPImageCropperDelegate,UITableViewDelegate,UITableViewDataSource {

    var BookTitle:BookTitleView?
    var table:UITableView?
    var  titleArray:Array<String> = []
    var book_Title = ""
    
    var scroe:LDXScore?
    
    var type="文学"
    var detailType="文学"
    
    var book_description = ""
    
    ////是否显示星星
    var showScroe  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.BookTitle = BookTitleView(frame: CGRectMake(0,60,SCREEN_WIDTH,160))
        self.BookTitle?.delegate = self
        self.view.addSubview(self.BookTitle!)
         self.titleArray = ["标题","评分","分类","书评"]
        self.table = UITableView(frame: CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-200), style: .Grouped)
        self.table?.tableFooterView = UIView()
        self.table?.delegate = self
        self.table?.dataSource = self
        self.table?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.table?.backgroundColor = UIColor(colorLiteralRed: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.view.addSubview(self.table!)
        
        self.scroe = LDXScore(frame: CGRectMake(100,10,100,30))
        self.scroe?.isSelect = true
        self.scroe?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.scroe?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.scroe?.max_star = 5
        self.scroe?.show_star = 5
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(pushNewViewController.pushNewViewControllerNotif(_:)) , name:"pushNewViewControllerNotif" , object: nil)
    }
    

    /**
     通知
     */
    func pushNewViewControllerNotif(notfication:NSNotification)  {
       
        let dic = notfication.userInfo
        if String(dic!["success"]!) == "true"{
            ProgressHUD.showSuccess("上传成功")
            self.dismissViewControllerAnimated(true, completion: { 
                
            })
        }else{
            ProgressHUD.showSuccess("上传失败")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    ///booktitleView Delegte
    func choicCover() {
       let vc = PhotoPickerViewController()
        vc.delegate = self
        self.presentViewController(vc, animated: true) { 
            
        }
        
    }
    
    ////photoPickerDelegat
    func getImageFromPicker(iamge: UIImage) {
    
        let croVC = VPImageCropperViewController(image: iamge, cropFrame: CGRectMake(0, 100, SCREEN_WIDTH,SCREEN_WIDTH*1.273), limitScaleRatio: 3)
        croVC.delegate = self
        self.presentViewController(croVC, animated: true) { 
            
        }
        
    }
    /////VPImageCropperViewdelegate 
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        
    }
    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        self.BookTitle?.BookCover?.setImage(editedImage, forState: .Normal)
        cropperViewController.dismissViewControllerAnimated(true) { 
            
        }
    }
    ////tableview delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        for view  in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        if indexPath.row != 1 {
            cell.accessoryType = .DisclosureIndicator
        }
        
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MA_FOUT, size: 15)
        cell.detailTextLabel?.font = UIFont(name: MA_FOUT, size: 13)
        
        var row = indexPath.row
        if  self.showScroe && row > 1 {
            row -= 1
        }
        
        switch row {
        case 0:
            cell.detailTextLabel?.text = self.book_Title
            break
        case 2:
            cell.detailTextLabel?.text = self.type + "->" + self.detailType
            break
        case 4:
            cell.accessoryType = .None
            let commentView = UITextView(frame: CGRectMake(14, 4, SCREEN_WIDTH-28, 80))
            commentView.text = self.book_description
            commentView.font = UIFont(name: MA_FOUT, size: 14)
            commentView.backgroundColor=UIColor.whiteColor()
            commentView.userInteractionEnabled=false
            cell.contentView.addSubview(commentView)
            break
        default:
            break
        }
        ////是否需要在第二行添加星星
        if self.showScroe && indexPath.row==2 {
            cell.contentView.addSubview(self.scroe!)
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.table?.deselectRowAtIndexPath(indexPath, animated: true)
        var row = indexPath.row
        if self.showScroe && row>1 {
            row -= 1
        }
        switch row {
            case 0:
                self.tableVSelectTitle()
                break
            case 1:
                self.tabelVSelectScore()
                break
            case 2:
                self.tableVSelectType()
                break
            case 3:
                self.tableVSelectDetill()
                break
            default:
                break
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if showScroe && indexPath.row >= 5 {
            return 88
        }else if !self.showScroe && indexPath.row >= 4
        {
            return 88
        }else{
            return 44
        }
    }
    
    ///选择标题
    func tableVSelectTitle(){
        let vc  = push_TitleViewController()
        GeneralFactory.addTitleWithTie(vc)
        vc.textField?.text=self.book_Title
        vc.callBack = ({(Title:String)->Void in
            self.book_Title = Title
            self.table?.reloadData()
        })
        self.presentViewController(vc, animated: true) {
        }
    }
    
    ///选择评分
    func tabelVSelectScore() {
        self.table?.beginUpdates()
        let tepIndexPath = [NSIndexPath(forItem: 2, inSection: 0)]
        if self.showScroe {
            self.titleArray.removeAtIndex(2)
            self.table?.deleteRowsAtIndexPaths(tepIndexPath, withRowAnimation: .Right)
            self.showScroe = false
        }else{
            self.titleArray.insert("", atIndex: 2)
            self.showScroe=true
            self.table?.insertRowsAtIndexPaths(tepIndexPath, withRowAnimation: .Left)
        }
        self.table?.endUpdates()
    }
    
    ////选择分类
    func tableVSelectType()  {
        let vc  = push_TypeViewController()
        GeneralFactory.addTitleWithTie(vc)
        vc.type=self.type
        vc.detailType=self.detailType
        vc.callBack=({(type:String,detailType:String)->Void in
            self.type=type
            self.detailType=detailType
            self.table?.reloadData()
        })
        let btn1 = vc.view.viewWithTag(123) as? UIButton
        let btn2 = vc.view.viewWithTag(124) as? UIButton
        btn1?.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        btn2?.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        self.presentViewController(vc, animated: true) {
        }
    }
    ////选择书评
    func tableVSelectDetill()  {
        let vc  = push_DetillViewController()
        GeneralFactory.addTitleWithTie(vc)
        vc.textView?.text = self.book_description
        vc.callBack = ({(description:String)->Void in
            self.book_description=description
            if self.titleArray.last == "" {
                self.titleArray.removeLast()
            }
            
            if description != "" {
                self.titleArray.append("")
            
            }
            self.table?.reloadData()
        })
        self.presentViewController(vc, animated: true) {
            
        }
    }
    
    func close()  {
        self.dismissViewControllerAnimated(true) {
        }
    }
    func sure() {
        let dict = ["BookName":(self.BookTitle?.BookName?.text)!,
                    "BookEdior":(self.BookTitle?.BookEditor?.text)!,
                    "BookCover": (self.BookTitle?.BookCover?.currentImage)!,
                    "title":self.book_Title,
                    "score":String(self.scroe?.show_star),
                    "type":self.type,
                    "detaileType":self.detailType,
                    "description":self.description]
        ProgressHUD.show("正在上传...")
        pushBook.pushBookInBack(dict)
        self.view.userInteractionEnabled=false
        
    }
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        print("内存没有泄露")
    }
    
}
