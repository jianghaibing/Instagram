//
//  LoginViewController.swift
//  Instagram
//
//  Created by baby on 15/11/7.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,JSAnimatedImagesViewDataSource {
    @IBOutlet weak var background: JSAnimatedImagesView!
    @IBOutlet weak var centerX: NSLayoutConstraint!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var decLable: UILabel!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var fbButton_reg: UIButton!
    @IBOutlet weak var emailTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.dataSource = self
        loginView.hidden = true
        emailTextField.becomeFirstResponder()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "emailTextDidChange:", name: UITextFieldTextDidChangeNotification, object: emailTextField)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarHidden = true
        self.navigationController?.navigationBarHidden = true
    }

    func emailTextDidChange(noti:NSNotification){
        if emailTextField.text == ""{
            fbButton_reg.hidden = false
            nextButton.hidden = true
        }else{
            fbButton_reg.hidden = true
            nextButton.hidden = false
        }
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "rainbow\(index)")
    }
    
    @IBAction func register(sender: UIButton) {
        centerX.constant = 0
        decLable.text = "注册Instagram，分享精彩世界"
        registerView.hidden = false
        loginView.hidden = true
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func login(sender: UIButton) {
        centerX.constant = loginButton.center.x - registerButton.center.x
        decLable.text = "登录就能查看好友的照片和视频啦"
        registerView.hidden = true
        loginView.hidden = false
        emailTextField.resignFirstResponder()
    }
    
    @IBAction func fbLogin(sender: UIButton) {
    }

    @IBAction func regNext(sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
