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
    @IBOutlet weak var followingContentView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var rightItemView: UIView!
    @IBOutlet weak var rightButtonW: NSLayoutConstraint!
    @IBOutlet weak var rightButtonH: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        headerTableView.delegate = self
        headerTableView.dataSource = self
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            if self.users == nil {
            self.requestUnfollowedUser()
            }else{
                self.tableView.mj_header.endRefreshing()
            }
        })
        tableView.mj_header.beginRefreshing()
        
    }
    
    //数据请求
    func requestUnfollowedUser(){
        
        let followeeQuery = AVQuery(className: "Follow")
        followeeQuery.whereKey("follower", equalTo: AVUser.currentUser().objectId)//查找当前用户关注的用户ID
        
        let queryNotMe = AVUser.query()
        queryNotMe.whereKey("objectId", notEqualTo: AVUser.currentUser().objectId)//查找非当前用户的ID
        let quaryFollowee = AVUser.query()
        quaryFollowee.whereKey("objectId", doesNotMatchKey: "following", inQuery: followeeQuery)//查找非关注的用户ID
        let query = AVQuery.andQueryWithSubqueries([queryNotMe,quaryFollowee])//执行符合查找，并集
        query.limit = 50
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                self.users = objects as? [AVUser]
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.mj_header.endRefreshing()
                    self.layoutFollowingView()
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
    
    func  layoutFollowingView(){
        //设置底部关注视图的高度
        if users?.count ?? 0 == 0 {
            followingContentView.frame.size.height = 0
        }else if users!.count == 1{
            followingContentView.frame.size.height = 110
        }else if users!.count == 2{
            followingContentView.frame.size.height = 170
        }else {
            followingContentView.frame.size.height = 230
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidScroll(tableView)
    }

    
    //MARK: - tableViewDelegate
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
            let imageFile = user["avatar"] as? AVFile
            if let imageFile = imageFile{
                let url = imageFile.url
                cell.avatar.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "anonymousUser"))
            }else{
                cell.avatar.image = UIImage(named: "anonymousUser")
                }
            
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
    func followingButtonDidClicked(cell: FollowingCell) {
        let indexPath = headerTableView.indexPathForCell(cell)
        let following = users![indexPath!.row]
        let follow = AVObject(className: "Follow")
        follow["following"] = following.objectId
        follow["follower"] = AVUser.currentUser().objectId
        follow.saveInBackgroundWithBlock { (sucessed, error) -> Void in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    cell.followingButton.selected = true
                    cell.followingButton.tintColor = UIColor.greenColor()
                    self.performSelector("recovery:", withObject: cell, afterDelay: 2)
                })
            }else{
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    MBProgressHUD.showErrortoView(self.view, with: error.localizedDescription)
                })
            }
        }
    }
    
    func colseButtonClicked(cell: FollowingCell) {
        
    }
    
    func recovery(cell:FollowingCell){
        let indexPath = headerTableView.indexPathForCell(cell)
        if self.users?.count > 3{
            self.users?[indexPath!.row] = self.users![3]
            self.users?.removeAtIndex(3)
            self.headerTableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Left)
            cell.followingButton.selected = false
            cell.followingButton.tintColor = globalColor
            headerTableView.reloadData()

        }
        
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let factor =  min(1, max(scrollView.contentOffset.y.distanceTo(0) / 64 , 0))
        
        self.navigationController?.navigationBar.frame.origin.y = 20 - 44 * (1 - factor)
       
        if factor == 0 {
            scrollView.contentInset.top = 20
            
        }else if factor != 1{//防止在刷新过程中重新设置contentinset
            scrollView.contentInset.top = 64
        }
        
        titleView.frame.size = CGSizeMake(150 * factor * factor, 33 * factor * factor)
        titleView.alpha = 1 * factor * factor
        rightButtonW.constant = 26 * factor * factor
        rightButtonH.constant = 26 * factor * factor
        rightItemView.alpha = 1 * factor * factor
        
    }
    
}

