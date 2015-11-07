//
//  ProfileViewController.swift
//  Instagram
//
//  Created by baby on 15/11/8.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logout"{
            AVUser.logOut()
            let loginVC = segue.destinationViewController as! LoginViewController
            loginVC.isLogout = true
        }
    }

}
