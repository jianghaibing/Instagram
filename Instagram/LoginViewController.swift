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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarHidden = true
        background.dataSource = self
        loginView.hidden = true
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    @IBAction func login(sender: UIButton) {
        centerX.constant = loginButton.center.x - registerButton.center.x
        decLable.text = "登录就能查看好友的照片和视频啦"
        registerView.hidden = true
        loginView.hidden = false
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
