//
//  ExtensionMBprogressHud.swift
//  Instagram
//
//  Created by baby on 15/11/10.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

extension MBProgressHUD {

    class func showErrortoView(view:UIView, with errorInfo:String){
        let errorHud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        errorHud.mode = .Text
        errorHud.yOffset = 200
        errorHud.labelText = errorInfo
        errorHud.hide(true, afterDelay: 2)
    }
}
