//
//  RegestViewController.swift
//  Instagram
//
//  Created by baby on 15/11/7.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class RegestViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        
        imagePickerVC.modalPresentationStyle = .CurrentContext
        imagePickerVC.allowsEditing = true
        imagePickerVC.navigationBar.tintColor = UIColor.whiteColor()
        imagePickerVC.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        imagePickerVC.navigationBar.barTintColor = globalColor
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        actionSheet.view.tintColor = globalColor
        let takePhotoAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action) -> Void in
            imagePickerVC.sourceType = .Camera
            self.presentViewController(imagePickerVC, animated: true, completion: nil)
        }
        let photoAction = UIAlertAction(title: "相册", style: .Default) { (action) -> Void in
            imagePickerVC.sourceType = .SavedPhotosAlbum
            self.presentViewController(imagePickerVC, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancel)
        
        if UIImagePickerController.isCameraDeviceAvailable(.Rear) || UIImagePickerController.isCameraDeviceAvailable(.Front){
        self.presentViewController(actionSheet, animated: true, completion: nil)
        }else{
            imagePickerVC.sourceType = .SavedPhotosAlbum
            self.presentViewController(imagePickerVC, animated: true, completion: nil)
        }
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let hud = MBProgressHUD.showHUDAddedTo(picker.view, animated: true)
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            let imageData = UIImageJPEGRepresentation(image, 0.7)
            imageFile = AVFile(name: "avatar.jpg", data: imageData)
            imageFile!.saveInBackgroundWithBlock({ (sucessed, error) -> Void in
                if sucessed == true {
                    hud.hide(true)
                    self.addPhotoButton.setImage(image, forState: .Normal)
                    self.onePhotoLabel.hidden = true
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    hud.hide(true)
                    MBProgressHUD.showErrortoView(picker.view, with: error.localizedDescription)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
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
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
