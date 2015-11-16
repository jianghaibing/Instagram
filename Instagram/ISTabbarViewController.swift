//
//  ISTabbarViewController.swift
//  Instagram
//
//  Created by baby on 15/11/5.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class ISTabbarViewController: UITabBarController,UITabBarControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var currentSelectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
      
        if tabBarController.selectedIndex == 2{
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.delegate = self
//            imagePickerVC.sourceType = .Camera
//            imagePickerVC.allowsEditing = true
//            imagePickerVC.showsCameraControls = false
//            let cameraOverlayVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("camera") as! PostPhotoViewController
//            cameraOverlayVC.view.frame = imagePickerVC.cameraOverlayView!.frame
//            imagePickerVC.cameraOverlayView = cameraOverlayVC.view
        
            imagePickerVC.navigationBar.tintColor = UIColor.whiteColor()
            imagePickerVC.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
            imagePickerVC.navigationBar.barTintColor = globalColor
            viewController.presentViewController(imagePickerVC, animated: true, completion: nil)
        }else {
            currentSelectedIndex = tabBarController.selectedIndex
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.selectedIndex = 0
            if let selectedViewController = self.selectedViewController {
                let homeVC = selectedViewController.childViewControllers[0] as! HomeViewController
                homeVC.imgArray.append(image)
                homeVC.tableView.reloadData()
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
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
