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
    dynamic var tableView:UITableView = UITableView()
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
            self.datas = json["stories"].arrayObject!
            self.tableView.reloadData()

        })
    }
    
    func setUI(){
        tableView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HJHomeTableViewCell.self, forCellReuseIdentifier: "cell")        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        
        //headView
//        headView.frame = CGRectMake(0, 0, view.frame.width, headViewHeight)
//        headView.backgroundColor = UIColor.redColor()
////        tableView.tableHeaderView = headView
//        HJExpandHeader.expandWithScrollView(tableView, expandView: headView)
        
        var image1:UIImageView = UIImageView(frame: CGRectMake(0, 0, Utility.kWidth, 150))
        image1.image = UIImage(named: "image")
        image1.clipsToBounds = true;
        image1.contentMode = UIViewContentMode.ScaleAspectFill;
        
        HJExpandHeader.expandWithScrollView(tableView, expandView: image1)

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HJHomeTableViewCell
        cell.frame = CGRectMake(0, 0, Utility.kWidth, 90)
        cell.type =  String((datas[indexPath.row]["type"] as? Int)!)
        cell.titleText = (datas[indexPath.row]["title"] as? String)!
        println(datas[indexPath.row].allKeys)
        
        if (datas[indexPath.row].objectForKey("images") != nil){
            let str:[String] = (datas[indexPath.row]["images"]) as! [String]
            println(str)
            ImageLoader.sharedLoader.imageForUrl(str[0] as String, completionHandler:{(image: UIImage?, url: String) in
                cell.rightImageView.image = image
            })
            
        }else if (datas[indexPath.row].objectForKey("image") != nil){
            let str:String = (datas[indexPath.row]["image"]) as! String
            ImageLoader.sharedLoader.imageForUrl(str as String, completionHandler:{(image: UIImage?, url: String) in
                cell.rightImageView.image = image
            })
            
        }

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
