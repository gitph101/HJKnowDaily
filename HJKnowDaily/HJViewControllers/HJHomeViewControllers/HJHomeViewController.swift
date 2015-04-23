//
//  HJHomeViewController.swift
//  HJKnowDaily
//
//  Created by 研究院01 on 15/4/15.
//  Copyright (c) 2015年 Loser. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
class HJHomeViewController: HJRootViewController ,SlideNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,RefreshControlDelegate{
    
    let headViewHeight:CGFloat = 250
    
    var datas = [AnyObject]()
    var headDatas = [AnyObject]()
    var currentDate:String = "20131119"
    
    dynamic var tableView:UITableView = UITableView()
    var headView:UIView = UIView()
    var headScrollView:UIScrollView = UIScrollView()

    var headTitleView:UIView = UIView()
    var headtitleScrollView:UIScrollView = UIScrollView()
    var pageContro:UIPageControl = UIPageControl()

    var refreshControl:RefreshControl = RefreshControl()
    
    override func viewDidLoad() {
//        self.navigationController?.navigationBar.hidden = true
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        loadData()
        setUI()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        // GUO WANG XIAOXI http://news.at.zhihu.com/api/4/news/before/20131119
        request.urlRequest("http://news-at.zhihu.com/api/4/news/latest", success: { (data,error) -> Void in
            let json:JSON = JSON(data!)
            println(json)
            self.datas = json["stories"].arrayObject!
            self.headDatas = json["top_stories"].arrayObject!
            self.currentDate = json["date"].stringValue
            self.tableView.reloadData()
            self.refreshView()
        })
    }
    
    
    func loadDataBefore(strdate:String){
        request.urlRequest("http://news-at.zhihu.com/api/4/news/latest", success: { (data,error) -> Void in
            let json:JSON = JSON(data!)
            println(json)
            self.datas = json["stories"].arrayObject!
            self.currentDate = json["date"].stringValue
            self.tableView.reloadData()
            self.refreshView()

        })
    }
    
    
    func setUI(){
    
        var bar = self.navigationController?.navigationBar
        bar?.tintColor = UIColor.whiteColor()
        bar?.translucent = true
        bar?.backgroundImageForBarMetrics(UIBarMetrics.Compact)
        bar?.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Compact)
        bar?.setBackgroundImage(UIImage(), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Compact)
        bar?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)


        tableView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        tableView = UITableView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height), style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HJHomeTableViewCell.self, forCellReuseIdentifier: "cell")        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        
        // 加载视图。
        headView.frame = CGRectMake(0, 0, view.frame.width, headViewHeight)
        
        headScrollView.frame = CGRectMake(0, 0, view.frame.width, headViewHeight)
        headScrollView.pagingEnabled = true
        headScrollView.showsHorizontalScrollIndicator = false
        headScrollView.showsVerticalScrollIndicator = false
        headScrollView.bounces = false
        headScrollView.tag = 100
        headScrollView.delegate = self
        headView.addSubview(headScrollView)
        headScrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        
        headTitleView.frame = CGRectMake(0, 0, view.frame.width, 60)
        
        headtitleScrollView.frame = CGRectMake(0, 0, view.frame.width, headViewHeight)
        headtitleScrollView.pagingEnabled = true
        headtitleScrollView.showsHorizontalScrollIndicator = false
        headtitleScrollView.showsVerticalScrollIndicator = false
        headtitleScrollView.bounces = false
        headtitleScrollView.tag = 200
        headtitleScrollView.delegate = self
        headTitleView.addSubview(headtitleScrollView)
        headtitleScrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        
        pageContro.frame = CGRectMake(0, headTitleView.frame.height - 20, view.frame.width, 20)
        pageContro.pageIndicatorTintColor = UIColor.grayColor()
        pageContro.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageContro.backgroundColor = UIColor.clearColor()
        pageContro.tag = 200
        pageContro.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        headTitleView.addSubview(pageContro)
        
        //视图效果及刷新
        HJExpandHeader.expandWithScrollView(tableView, expandView: headView)
        
        tableView.addPullToRefreshActionHandler({ () -> Void in
            //            self.tableView.stopRefreshAnimation
            
            }, navigationController: self.navigationController)
        tableView.stopRefreshAnimation()
        
        //上拉加载
        refreshControl = RefreshControl(scrollView: tableView, delegate: self)
        refreshControl.bottomEnabled = false;
        refreshControl.topEnabled = false;


    }
    
    func refreshView(){
        for i in 0...headDatas.count - 1{
            let index:CGFloat = CGFloat(i)
            let view = UIImageView(frame: CGRectMake((index) * headScrollView.frame.width , 0, headScrollView.frame.width, headScrollView.frame.height))
            view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth

            headScrollView.addSubview(view)
            if (headDatas[i].objectForKey("image") != nil){
                let image:String = headDatas[i].objectForKey("image") as! String
                ImageLoader.sharedLoader.imageForUrl(image as String, completionHandler:{(image: UIImage?, url: String) in
                    view.image = image
                })
                
            }else if (headDatas[i].objectForKey("images") != nil){
                let image:String = headDatas[i].objectForKey("images") as! String
                ImageLoader.sharedLoader.imageForUrl(image as String, completionHandler:{(image: UIImage?, url: String) in
                    view.image = image
                })
                
            }
            let image:String = headDatas[i].objectForKey("image") as! String
            ImageLoader.sharedLoader.imageForUrl(image as String, completionHandler:{(image: UIImage?, url: String) in
                view.image = image
            })
            
            var headTitleLable = UILabel()
            headTitleLable.font = UIFont.boldSystemFontOfSize(17)
            headTitleLable.textColor = UIColor.whiteColor()
            headTitleLable.frame = CGRectMake((index) * headScrollView.frame.width , 0, headScrollView.frame.width, headTitleView.frame.height) // 这里位置。
            headTitleLable.numberOfLines = 0
            headTitleLable.text = "标题在哪里"
            headtitleScrollView.addSubview(headTitleLable)
            headTitleLable.text = headDatas[i].objectForKey("title") as? String
        }
        headScrollView.contentSize = CGSizeMake(headScrollView.frame.width * CGFloat(headDatas.count), headScrollView.frame.height)
        pageContro.numberOfPages = headDatas.count
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
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headTitleView
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRectMake(0, 0, 0, 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
    
    // MARK: - ScrllViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.tag == 100{
            var index = scrollView.contentOffset.x / scrollView.frame.width
            pageContro.currentPage = Int(index)
            
            headtitleScrollView.contentOffset = scrollView.contentOffset
        }
    }
    
    // MARK: - refreshControlDelegate
    func refreshControl(refreshControl: RefreshControl!, didEngageRefreshDirection direction: RefreshDirection) {
        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        tableView.triggerPullToRefresh()
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
