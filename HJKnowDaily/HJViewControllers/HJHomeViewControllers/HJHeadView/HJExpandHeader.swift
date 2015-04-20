//
//  HJExpandHeader.swift
//  HJKnowDaily
//
//  Created by 研究院01 on 15/4/20.
//  Copyright (c) 2015年 Loser. All rights reserved.
//

import UIKit

class HJExpandHeader: NSObject,UIScrollViewDelegate {
    let HJExpandContentOffset = "contentOffset"
    
   dynamic weak var scrollView:UIScrollView?//=UIScrollView()
    weak var expandView:UIView?//=UIView()
    
    var expandHeight:CGFloat = 200
    
    class func expandWithScrollView(scrollView:UIScrollView,expandView:UIView)->HJExpandHeader{
        var expandHeader:HJExpandHeader = HJExpandHeader()
        expandHeader.expandWithScrollView(scrollView, tempView: expandView)
        return expandHeader
    }
    
    func expandWithScrollView(tempScorllView:UIScrollView, tempView:UIView){
        
        expandView = tempView
        scrollView = tempScorllView
        
        expandHeight = CGRectGetHeight(tempView.frame)

        scrollView = tempScorllView
        scrollView!.backgroundColor = UIColor.clearColor()
        scrollView!.contentInset = UIEdgeInsetsMake(expandHeight, 0, 0, 0);
        scrollView!.insertSubview(expandView!, atIndex: 0)

        // KVO 监听值的变化
        scrollView!.addObserver(self, forKeyPath: HJExpandContentOffset, options:NSKeyValueObservingOptions.New, context: nil)
        scrollView!.contentOffset = CGPointMake(0, -180)
        
        //使View可以伸展效果  重要属性
        expandView!.contentMode = UIViewContentMode.ScaleAspectFill
        expandView!.clipsToBounds = true
        
        reSizeView()
    }
    
      // 重置位置
    func reSizeView(){
        expandView!.frame = CGRectMake(0, expandHeight * -1, CGRectGetWidth(expandView!.frame), expandHeight)
    }
    
    
    
     override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath != HJExpandContentOffset{
            return
        }
        scrollViewDidScroll(scrollView!)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var offfsetY:CGFloat = scrollView.contentOffset.y
        if offfsetY < (expandHeight * -1){
            var currentFrame:CGRect = expandView!.frame
            currentFrame.origin.y = offfsetY
            currentFrame.size.height = offfsetY * -1
            expandView!.frame  = currentFrame
        }

    }
    
    func animationForScrollView(){
        var offsetY = scrollView!.contentOffset.y
        if scrollView!.contentOffset.y > 0{

        }else{
         expandView!.frame = CGRectMake(offsetY, 0,scrollView!.frame.size.width + (offsetY) * -2, self.expandHeight - offsetY)
        }
    }
    
    deinit {
        scrollView!.removeObserver(self, forKeyPath: HJExpandContentOffset)
    }
    

}
