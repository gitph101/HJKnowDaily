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
    
    weak var scrollView:UIScrollView?//=UIScrollView()
    weak var expandView:UIView?//=UIView()
    
    var expandHeight:CGFloat = 0
    
    
    static let expandHeader:HJExpandHeader = HJExpandHeader()
    
    class func expandWithScrollView(scrollView:UIScrollView,expandView:UIView)->HJExpandHeader{
        expandHeader.expandWithScrollView(scrollView, tempView: expandView)
        return expandHeader
    }
    
    func expandWithScrollView(tempScorllView:UIScrollView, tempView:UIView){
        
        expandView = tempView
        scrollView = tempScorllView
        
        expandHeight = CGRectGetHeight(tempView.frame)
//        expandView?.frame = CGRectMake(0, 0, Utility.kWidth, 400);
        
        
        scrollView = tempScorllView
        scrollView!.backgroundColor = UIColor.clearColor()
        scrollView!.contentInset = UIEdgeInsetsMake(expandHeight - 64 - 100, 0, 0, 0);
        scrollView!.insertSubview(expandView!, atIndex: 0)
        println(scrollView?.contentOffset)
        var offfsetY:CGFloat = scrollView!.contentOffset.y
        println("偏移量2" + String(stringInterpolationSegment: offfsetY))
        // KVO 监听值的变化
        scrollView!.addObserver(self, forKeyPath: HJExpandContentOffset, options:NSKeyValueObservingOptions.New, context: nil)
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
        
        
        var offfsetY:CGFloat = scrollView!.contentOffset.y
        println("偏移量1" + String(stringInterpolationSegment: offfsetY))
        if keyPath != HJExpandContentOffset{
            return
        }
        scrollViewDidScroll(scrollView!)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 这里偏移量变成 200
        var offfsetY:CGFloat = scrollView.contentOffset.y
        println("偏移量" + String(stringInterpolationSegment: offfsetY))
        
        
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
