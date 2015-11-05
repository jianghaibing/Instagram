//
//  ISTabBar.swift
//  Instagram
//
//  Created by baby on 15/11/6.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class ISTabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for (index,tabbarButton) in self.subviews.enumerate() {
            if index == 3 {
                if tabbarButton.isKindOfClass(NSClassFromString("UITabBarButton")!){//用字符串转化成类获取类
                    tabbarButton.subviews[0].backgroundColor = UIColor.grayColor()
                }

            }
        }
    }
    
}
