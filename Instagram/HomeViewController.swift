//
//  ViewController.swift
//  Instagram
//
//  Created by baby on 15/11/5.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    var imgArray:[UIImage] = []
    @IBOutlet weak var headerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        headerTableView.delegate = self
        headerTableView.dataSource = self
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == headerTableView {
            return 1
        }else{
            return imgArray.count
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == headerTableView {
            return 3
        }else{
        return 1
        }
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == headerTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("following", forIndexPath: indexPath) as! FollowingCell
            return cell
        }else{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PhotoCell
        cell.photoView.image = imgArray[indexPath.section]
        return cell
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView != headerTableView{
        let header = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderViewCell
        return header
        }else{
        let header = tableView.dequeueReusableCellWithIdentifier("topCell")
            
        return header
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView != headerTableView{
            return 60
        }else{
            return 45
        }
    }
}

