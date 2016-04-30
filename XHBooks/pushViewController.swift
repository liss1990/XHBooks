//
//  pushViewController.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/18.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

class pushViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    
    var dataArray=NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        self.setNavigionBar()
        
       self.tableView=UITableView(frame:self.view.frame)
        self.tableView?.delegate=self
        self.tableView?.dataSource=self
        self.view.addSubview(self.tableView!)
        self.tableView?.tableFooterView=UIView()
        self.tableView?.registerClass(pushBookCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.mj_header=MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pushViewController.headerRefresh))
        self.tableView?.mj_footer=MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(pushViewController.footerRefresh))
//        self.tableView?.mj_header.beginRefreshing()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView?.mj_header.beginRefreshing()
    }
    func headerRefresh() {
        
        let query = AVQuery(className: "Book")
        query.orderByDescending("createdAt")
        query.limit=20
        query.skip=0
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (results, error) in
            self.tableView?.mj_header.endRefreshing()
            self.dataArray.removeAllObjects()
            self.dataArray.addObjectsFromArray(results)
            self.tableView?.reloadData()
        }
        
        
    }
    func footerRefresh() {
        let query = AVQuery(className: "Book")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip=self.dataArray.count
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (results, error) in
            self.tableView?.mj_footer.endRefreshing()
            if results.count==0
            {
                self.tableView?.mj_footer.endRefreshingWithNoMoreData()
            }else{
                self.dataArray.addObject(results)
                self.tableView?.reloadData()
            }
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? pushBookCell
        let dict = self.dataArray[indexPath.row] as? AVObject
        
        cell!.BookName?.text="《"+(dict!["BookName"] as! String)+"》:"+(dict!["title"] as! String)
        cell!.Editor?.text="作者:"+(dict!["BookEdior"] as!String )
        
        let date = dict!["createdAt"] as? NSDate
        let formate = NSDateFormatter()
        formate.dateFormat="yyyy-MM-dd hh:mm"
        cell?.more?.text=formate.stringFromDate(date!)
        let coverFile = dict!["cover"] as? AVFile
        let image=UIImage(named: "bookPage")
        cell?.cover?.sd_setImageWithURL(NSURL(string: (coverFile?.url)!), placeholderImage: image)
        
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavigionBar() {
        
        let navigationView = UIView(frame: CGRectMake(0,-20,SCREEN_WIDTH,65))
        navigationView.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        let addBookBtn = UIButton(frame: CGRectMake(20,20,SCREEN_WIDTH,45))
        addBookBtn.setImage(UIImage(named: "add2"), forState: .Normal)
        addBookBtn.setTitle("  新建书评", forState: .Normal)
        addBookBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addBookBtn.titleLabel?.font = UIFont(name: MA_FOUT, size: 15)
        addBookBtn.contentHorizontalAlignment = .Left
        addBookBtn.addTarget(self, action: #selector(pushViewController.pushNewBook), forControlEvents: .TouchUpInside)
        navigationView.addSubview(addBookBtn)
    }
    
    func pushNewBook() {
        let vc = pushNewViewController()
        GeneralFactory.addTitleWithTie(vc, title1: "关闭", title2: "保存")
        self.presentViewController(vc, animated: true) {
        }
    }
}
