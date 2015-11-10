//
//  ViewController.swift
//  Instagram
//
//  Created by baby on 15/11/5.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController,FollowingCellDelegate {

    var imgArray:[UIImage] = []
    @IBOutlet weak var headerTableView: UITableView!
    var users:[AVUser]?
    var avatars:[UIImageView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        headerTableView.delegate = self
        headerTableView.dataSource = self
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.requestUnfollowedUser()
        })
        tableView.mj_header.beginRefreshing()
     
    }
    
    func requestUnfollowedUser(){
        
        let query = AVUser.query()
        query.whereKey("objectId", notEqualTo: AVUser.currentUser().objectId)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                self.users = objects as? [AVUser]
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.mj_header.endRefreshing()
                    self.headerTableView.reloadData()
                })
            }else{
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.mj_header.endRefreshing()
                    MBProgressHUD.showErrortoView(self.view, with: error.localizedDescription)
                })
            }
        }
        
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
            return min(users?.count ?? 0 , 3)
        }else{
        return 1
        }
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == headerTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("following", forIndexPath: indexPath) as! FollowingCell
            if let users = users{
            let user = users[indexPath.row]
            let imageFile = user["avatar"] as! AVFile
            let url = imageFile.url
            cell.avatar.sd_setImageWithURL(NSURL(string: url))
            cell.nameLabel.text = user.username
            }
            cell.delegate = self
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
    
    //MARK: - followingCellDelegate
    func followingCellDidClicked(cell: FollowingCell) {
        let indexPath = headerTableView.indexPathForCell(cell)
        let following = users![indexPath!.row]
        let follow = AVObject(className: "Follow")
        follow["following"] = following
        follow["follower"] = AVUser.currentUser()
        follow.saveInBackgroundWithBlock { (sucessed, error) -> Void in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    cell.followingButton.selected = true
                    cell.followingButton.tintColor = UIColor.greenColor()
                })
            }else{
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    MBProgressHUD.showErrortoView(self.view, with: error.localizedDescription)
                })
            }
        }
    }
}

