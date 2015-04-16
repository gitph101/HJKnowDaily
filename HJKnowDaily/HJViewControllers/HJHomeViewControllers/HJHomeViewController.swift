//
//  HJHomeViewController.swift
//  HJKnowDaily
//
//  Created by 研究院01 on 15/4/15.
//  Copyright (c) 2015年 Loser. All rights reserved.
//

import UIKit

class HJHomeViewController: HJRootViewController ,SlideNavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        loadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        request.urlRequest("http://news-at.zhihu.com/api/4/news/latest", success: { (data,error) -> Void in
            
        })
    }
    /*
    let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(dataFromTwitter, options: NSJSONReadingOptions.MutableContainers, error: nil)
    if let statusesArray = jsonObject as? NSArray{
    if let aStatus = statusesArray[0] as? NSDictionary{
    if let user = aStatus["user"] as? NSDictionary{
    if let userName = user["name"] as? NSDictionary{
    //Finally We Got The Name
    
    }
    }
    }
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//        NSJSONSerialization.j
        // Dispose of any resources that can be recreated.
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
