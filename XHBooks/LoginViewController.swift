//
//  LoginViewController.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/27.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passWord.delegate=self
        userName.delegate=self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag==1{
            UIView.animateWithDuration(0.3, animations: { 
                  self.topConstraint.constant = -100
                self.view.layoutIfNeeded()
            })
          
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag==1{
            UIView.animateWithDuration(0.3, animations: {
                self.topConstraint.constant = 8
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
    
    @IBOutlet var hideKeyB: UITapGestureRecognizer!
    

    @IBAction func iii(sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func login(sender: AnyObject) {
        ProgressHUD.show("正在登陆....")
        AVUser.logInWithUsernameInBackground(self.userName.text, password: self.passWord.text) { (user, error) in
            if error == nil{
                self.dismissViewControllerAnimated(true, completion: { 
                    ProgressHUD.showSuccess("登陆成功")
                })
            }else{
                if error.code == 201
                {
                    ProgressHUD.showError("用户名或密码错误")
                }else if error.code == 211
                {
                    ProgressHUD.showError("不存在该用户")
                }else if error.code == 216
                {
                    ProgressHUD.showError("未验证邮箱")
                }
                else if error.code == 1
                {
                    ProgressHUD.showError("操作频繁")
                }else{
                    ProgressHUD.showError("登陆失败")
                }
                
            
            }
            
        }
        
        
    }

}
