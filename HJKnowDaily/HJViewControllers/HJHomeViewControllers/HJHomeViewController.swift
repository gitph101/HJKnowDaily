//
//  HJHomeViewController.swift
//  HJKnowDaily
//
//  Created by 研究院01 on 15/4/15.
//  Copyright (c) 2015年 Loser. All rights reserved.
//

import UIKit
import SwiftyJSON
class HJHomeViewController: HJRootViewController ,SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate{
    
    let headViewHeight:CGFloat = 80
    var tableView:UITableView = UITableView()
    var datas = [AnyObject]()
    var headView:UIView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        loadData()
        setUI()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        request.urlRequest("http://news-at.zhihu.com/api/4/news/latest", success: { (data,error) -> Void in
            let json:JSON = JSON(data!)
            println(json)
            println(json["date"].stringValue)
            self.datas = json["stories"].arrayObject!
            self.tableView.reloadData()
            println(json["stories"].arrayObject![0]["title"])

        })
    }
    
    func setUI(){
        tableView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HJHomeTableViewCell.self, forCellReuseIdentifier: "cell")        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        
        //headView
        headView.frame = CGRectMake(0, 0, view.frame.width, headViewHeight)
        headView.backgroundColor = UIColor.redColor()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HJHomeTableViewCell
        cell.frame = CGRectMake(0, 0, Utility.kWidth, 90)
        cell.type =  String((datas[indexPath.row]["type"] as? Int)!)
        cell.titleText = (datas[indexPath.row]["title"] as? String)!
        
        println(datas[indexPath.row].allKeys)
//        let str:String = (datas[indexPath.row]["image"] as? String)!
//        ImageLoader.sharedLoader.imageForUrl(str, completionHandler:{(image: UIImage?, url: String) in
//            cell.imageView!.image = image
//        })
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
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
