//
//  PostPhotoViewController.swift
//  Instagram
//
//  Created by baby on 15/11/15.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class PostPhotoViewController:UIViewController{

    lazy var imagePickerVC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePickerVC.sourceType = .SavedPhotosAlbum
        imagePickerVC.navigationBar.tintColor = UIColor.whiteColor()
        imagePickerVC.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        imagePickerVC.navigationBar.barTintColor = globalColor
        addChildViewController(imagePickerVC)
        
        imagePickerVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44)
        
        view.addSubview(imagePickerVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectPhotoVC(sender: UIBarButtonItem) {
        imagePickerVC.sourceType = .SavedPhotosAlbum
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    @IBAction func selectTakePhotoVC(sender: UIBarButtonItem) {

        imagePickerVC.sourceType = .Camera
        


    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//        self.selectedIndex = currentSelectedIndex
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
