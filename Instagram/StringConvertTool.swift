//
//  StringConvertTool.swift
//  SinaWeibo
//
//  Created by baby on 15/9/2.
//  Copyright © 2015年 Beijing Gold Finger Education Technology LLC. All rights reserved.
//

import UIKit

class StringConvertTool: NSObject {
    
    class func dateStringConverter(date:NSDate) -> String {
        let df = NSDateFormatter()
//        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
//        df.locale = NSLocale(localeIdentifier: "en_US")
//        let date = df.dateFromString(oldString)
        let now = NSDate()
        
        let createdYear = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: date)
        let thisYear = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: now)
        
        let deltaTimeInterval = Int(now.timeIntervalSinceDate(date))
        
        if createdYear != thisYear {
            df.dateFormat = "yyyy-MM-dd HH:mm"
        }else if deltaTimeInterval >= 3600*24*2 {
            df.dateFormat = "MM-dd HH:mm"
        }else if deltaTimeInterval >= 3600*24 && deltaTimeInterval < 3600*24*2 {
            df.dateFormat = "昨天 HH:mm"
        }else if deltaTimeInterval >= 3600 && deltaTimeInterval < 3600*24 {
            df.dateFormat = "\(deltaTimeInterval/3600)小时之前"
        }else if deltaTimeInterval >= 60 && deltaTimeInterval < 3600 {
            df.dateFormat = "\(deltaTimeInterval/60)分钟之前"
        }else if deltaTimeInterval < 60 {
            df.dateFormat = "刚刚"
        }
        return df.stringFromDate(date)
    }
    
    class func sourceStringConverter(oldSouce:String) -> String {
        if let range = oldSouce.rangeOfString(">") {
            let subStr1 = oldSouce.substringFromIndex(range.endIndex)
            let range1 = subStr1.rangeOfString("<")
            let subStr = subStr1.substringToIndex(range1!.startIndex)
            return "来自 " + subStr
        }else{
            return oldSouce
        }
        
    }

}
