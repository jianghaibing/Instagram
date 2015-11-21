//
//  ISTabbarViewController.swift
//  Instagram
//
//  Created by baby on 15/11/5.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class ISTabbarViewController: UITabBarController,UITabBarControllerDelegate,DBCameraViewControllerDelegate {

    var currentSelectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
      
        if tabBarController.selectedIndex == 2{
            let cameraContainer = DBCameraContainerViewController(delegate: self)
            cameraContainer.setFullScreenMode()
            let nav = BaseNavgationController(rootViewController: cameraContainer)
            nav.navigationBarHidden = true
            UIApplication.sharedApplication().statusBarHidden = true
            viewController.presentViewController(nav, animated: true, completion: nil)
        }else {
            currentSelectedIndex = tabBarController.selectedIndex
        }
    }
    

    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        let post = AVObject(className: "Post")
        post["postUserID"] = AVUser.currentUser().objectId
        
        
        let imageData = UIImageJPEGRepresentation(image, 0.7)
        let imageFile = AVFile(name: "post.jpg", data: imageData)
        let hud = MBProgressHUD.showHUDAddedTo(cameraViewController.view, animated: true)
        imageFile!.saveInBackgroundWithBlock({ (sucessed, error) -> Void in
            if sucessed == true {
                
                post["postImage"] = imageFile
                
                post.saveInBackgroundWithBlock({ (sucessed, error) -> Void in
                    if error == nil{
                       
                        UIApplication.sharedApplication().statusBarHidden = false
                        self.selectedIndex = 0
                        if let selectedViewController = self.selectedViewController {
                            let homeVC = selectedViewController.childViewControllers[0] as! HomeViewController
                            hud.hide(true)
                            homeVC.requestNewPost()
                            homeVC.tableView.reloadData()
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                       
                    }else{
                        hud.hide(true)
                        MBProgressHUD.showErrortoView((cameraViewController?.view)!, with: error.localizedDescription)
                    }
                })
                
            }else{
                hud.hide(true)
                MBProgressHUD.showErrortoView((cameraViewController?.view)!, with: error.localizedDescription)
                
            }
        })
        
        
    
    }

    func dismissCamera(cameraViewController: AnyObject!) {
        UIApplication.sharedApplication().statusBarHidden = false
        self.dismissViewControllerAnimated(true, completion: nil)
        self.selectedIndex = currentSelectedIndex

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
