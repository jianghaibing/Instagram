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
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginActionButton: UIButton!
    
    var isLogout:Bool = false//如果是退出状态，设置tab到登录界面

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.dataSource = self
        loginView.hidden = true
        emailTextField.becomeFirstResponder()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "emailTextDidChange:", name: UITextFieldTextDidChangeNotification, object: emailTextField)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "emailTextDidChange:", name: UITextFieldTextDidChangeNotification, object: passwordTextField)
        
        if isLogout {
            login(loginButton)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarHidden = true
        self.navigationController?.navigationBarHidden = true
    }

    func emailTextDidChange(noti:NSNotification){
        if noti.object as! UITextField == emailTextField{
        if emailTextField.text == ""{
            fbButton_reg.hidden = false
            nextButton.hidden = true
        }else{
            fbButton_reg.hidden = true
            nextButton.hidden = false
        }
        }
        if noti.object as! UITextField == passwordTextField{
            if passwordTextField.text == "" {
                forgotPassword.hidden = false
                loginActionButton.hidden = true
            }else {
                forgotPassword.hidden = true
                loginActionButton.hidden = false
            }
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

    @IBAction func loginButtonAction(sender: UIButton) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        if sender.titleLabel?.text != ""{
            AVUser.logInWithUsernameInBackground(userNameTextField.text, password: passwordTextField.text, block: { (user, error) -> Void in
                if user != nil {
                    hud.hide(true)
                    self.performSegueWithIdentifier("showHome", sender: self)
                }else {
                    print(error)
                    hud.hide(true)
                    let errorHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    errorHud.mode = .Text
                    errorHud.labelText = "用户名密码错误，请检查"
                    errorHud.hide(true, afterDelay: 2)
                }
            })
        }
    }
    @IBAction func forgotPassword(sender: UIButton) {
       
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "regester"{
        let regVC = segue.destinationViewController as! RegestViewController
        regVC.emailSting = emailTextField.text!
        }
    }
    

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
