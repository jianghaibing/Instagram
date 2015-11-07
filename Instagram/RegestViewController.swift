//
//  RegestViewController.swift
//  Instagram
//
//  Created by baby on 15/11/7.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class RegestViewController: UITableViewController {
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var regestItem: UIBarButtonItem!
    
    var emailSting:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoButton.layer.cornerRadius = 40
        addPhotoButton.layer.masksToBounds = true
        emailTextField.text = emailSting
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChanged:", name: UITextFieldTextDidChangeNotification, object: emailTextField)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChanged:", name: UITextFieldTextDidChangeNotification, object: userNameTextField)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChanged:", name: UITextFieldTextDidChangeNotification, object: passwordTextField)
    }
    
    func textFieldDidChanged(noti:NSNotification){
        if emailTextField.text != "" && userNameTextField.text != "" && passwordTextField.text != "" {
            regestItem.enabled = true
        }else{
            regestItem.enabled = false
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarHidden = false
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func regiest(sender: UIBarButtonItem) {
        let user = AVUser()
        user.email = emailTextField.text
        user.username = userNameTextField.text
        user.password = passwordTextField.text
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        user.signUpInBackgroundWithBlock { (sucessed, error) -> Void in
            if sucessed == true {
                hud.hide(true)
                self.performSegueWithIdentifier("singnUpSucessed", sender: self)
            }else{
                print(error)
                hud.hide(true)
                let errorHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                errorHud.mode = .Text
                errorHud.labelText = "账号注册失败，请检查"
                errorHud.hide(true, afterDelay: 2)
            }
        }
    }
    
    @IBAction func choosePhoto(sender: UIButton) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
