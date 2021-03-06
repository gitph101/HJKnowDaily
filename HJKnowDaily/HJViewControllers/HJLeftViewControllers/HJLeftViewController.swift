//
//  HJLeftViewController.swift
//  HJKnowDaily
//
//  Created by 研究院01 on 15/4/15.
//  Copyright (c) 2015年 Loser. All rights reserved.
//

import UIKit

class HJLeftViewController: HJRootViewController,UITableViewDataSource,UITableViewDelegate {
    
    let headViewHeight:CGFloat = 80
    var tableView:UITableView = UITableView()
    var datas = ["第一季","第二类","第三类","第四类","第五类"]
    var headView:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI(){
        tableView.frame = CGRectMake(0, headViewHeight, view.frame.width, view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        
        //headView
        headView.frame = CGRectMake(0, 0, view.frame.width, headViewHeight)
        headView.backgroundColor = UIColor.redColor()
        view.addSubview(headView)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.textAlignment = NSTextAlignment.Left
        cell.textLabel?.text = datas[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        SlideNavigationController.sharedInstance().popToRootViewControllerAnimated(true)
    }
    // MARK: - SlideNavigationController Methods
   


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
