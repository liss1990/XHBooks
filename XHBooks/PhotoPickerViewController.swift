//
//  PhotoPickerViewController.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/20.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

protocol PhotoPickerDelegate {
    func getImageFromPicker(iamge:UIImage)
}

class PhotoPickerViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var alert:UIAlertController?
    var picker:UIImagePickerController!
    
    var delegate:PhotoPickerDelegate!
   
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .OverFullScreen  /// 设置背景为透明的
        self.view.backgroundColor = UIColor.clearColor()
        
        self.picker = UIImagePickerController()
        self.picker?.allowsEditing = false
        self.picker?.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if self.alert == nil {
            self.alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            self.alert?.addAction(UIAlertAction(title: "从相册打开", style: .Default, handler: { (action) in
                self.localPhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "打开相机", style: .Default, handler: { (action) in
                self.takePhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (action) in
                self.dismissViewControllerAnimated(true, completion: {
                    
                })
            }))
            self.presentViewController(self.alert!, animated: true, completion: { 
                
            })
        }
    }
    ///打开相机
    func  takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            self.picker?.sourceType = .Camera
            self.presentViewController(self.picker, animated: true
                , completion: { 
                    
            })
            
        }else{
            let alertView = UIAlertController(title: "此机型无相机", message: nil, preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "关闭", style: .Cancel, handler: { (action) in
                self.dismissViewControllerAnimated(true, completion: { 
                    
                })
            }))
            
            self.presentViewController(alertView, animated: true, completion: { 
            })
            
            
        }
    }
    
    ///打开相册
    func localPhoto() {
        self.picker.sourceType = .PhotoLibrary
        self.presentViewController(self.picker, animated: true) { 
            
        }
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.picker?.dismissViewControllerAnimated(true, completion: { 
            self.dismissViewControllerAnimated(true, completion: { 
                
            })
        })
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picker?.dismissViewControllerAnimated(true, completion: {
            self.dismissViewControllerAnimated(true, completion: {
               self.delegate.getImageFromPicker(image)
            })
        })
        
        
        
    }
    
    
    
}
