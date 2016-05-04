//
//  RegisterViewController.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/27.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.password.delegate=self
        self.email.delegate=self
        self.userName.delegate=self
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func touch(sender: AnyObject) {
        self.view.endEditing(true)
        
        
    }
    @IBAction func register(sender: AnyObject) {
        ProgressHUD.show("注册中请稍后....")
        let user = AVUser()
        user.username = self.userName.text
        user.password = self.password.text
        user.email = self.email.text
        user.signUpInBackgroundWithBlock { (succerr, error) in
            if succerr {
                ProgressHUD.showSuccess("注册邮箱，请验证邮箱")
                self.dismissViewControllerAnimated(true, completion: { 
                    
                })
            }else
            {
                if error.code == 125
                {
                    ProgressHUD.showError("邮箱不合法")
                }else if error.code == 203 {
                    
                    ProgressHUD.showError("该邮箱已注册")
                }else if error.code == 202 {
                    
                    ProgressHUD.showError("用户名已存在")
                }else{
                    ProgressHUD.showError("注册失败")
                }
            }
            
        }
        
        
    }
    @IBAction func close(sender: AnyObject) {
      self.dismissViewControllerAnimated(true) { 
        
        }
    }
}
