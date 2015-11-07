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

    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoButton.layer.cornerRadius = 40
        addPhotoButton.layer.masksToBounds = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarHidden = false
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(true)
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
