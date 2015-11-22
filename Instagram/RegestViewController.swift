//
//  RegestViewController.swift
//  Instagram
//
//  Created by baby on 15/11/7.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class RegestViewController: UITableViewController,DBCameraViewControllerDelegate {
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var regestItem: UIBarButtonItem!
    @IBOutlet weak var onePhotoLabel: UILabel!
    
    var imageFile:AVFile?
    var emailSting:String?

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
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        let user = AVUser()
        user.email = emailTextField.text
        user.username = userNameTextField.text
        user.password = passwordTextField.text
        if imageFile != nil {
        user["avatar"] = imageFile
        }
        user.signUpInBackgroundWithBlock { (sucessed, error) -> Void in
            if sucessed == true {
                hud.hide(true)
                self.performSegueWithIdentifier("singnUpSucessed", sender: self)
            }else{
                print(error)
                hud.hide(true)
                MBProgressHUD.showErrortoView(self.view, with: error.localizedDescription)
            }
        }
        
       
    }
    
    @IBAction func choosePhoto(sender: UIButton) {
        
        let cameraController = DBCameraViewController.initWithDelegate(self)
        cameraController.forceQuadCrop = true
        
        let container = DBCameraContainerViewController(delegate: self)
        container.cameraViewController = cameraController
        container.setFullScreenMode()
        
        let nav = BaseNavgationController(rootViewController: container)
        nav.navigationBarHidden = true
        UIApplication.sharedApplication().statusBarHidden = true
        self.presentViewController(nav, animated: true, completion: nil)
        
        
    }
    
    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        let hud = MBProgressHUD.showHUDAddedTo(cameraViewController.view, animated: true)
        
        let imageData = UIImageJPEGRepresentation(image, 0.7)
        imageFile = AVFile(name: "avatar.jpg", data: imageData)
        imageFile!.saveInBackgroundWithBlock({ (sucessed, error) -> Void in
            if sucessed == true {
                hud.hide(true)
                self.addPhotoButton.setImage(image, forState: .Normal)
                self.onePhotoLabel.hidden = true
                UIApplication.sharedApplication().statusBarHidden = false
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                hud.hide(true)
                MBProgressHUD.showErrortoView((cameraViewController?.view)!, with: error.localizedDescription)
                UIApplication.sharedApplication().statusBarHidden = false
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        })
        

    }
    
    func dismissCamera(cameraViewController: AnyObject!) {
        UIApplication.sharedApplication().statusBarHidden = false
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
