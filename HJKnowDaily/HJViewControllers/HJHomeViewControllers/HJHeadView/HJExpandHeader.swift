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
    let HJImageHeight:CGFloat = 120
    let HJImageTopHeight:CGFloat = 30
    let HJImageBottomHeight:CGFloat = 80
    
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
        
        scrollView = tempScorllView
        scrollView!.backgroundColor = UIColor.clearColor()
        scrollView!.contentInset = UIEdgeInsetsMake(expandHeight - 64 - HJImageTopHeight - HJImageBottomHeight, 0, 0, 0); // 设置headView 显示大小。
        scrollView!.insertSubview(expandView!, atIndex: 0)
        println(scrollView?.contentOffset)
        var offfsetY:CGFloat = scrollView!.contentOffset.y
        // KVO 监听值的变化
        scrollView!.addObserver(self, forKeyPath: HJExpandContentOffset, options:NSKeyValueObservingOptions.New, context: nil)
        //使View可以伸展效果  重要属性
        expandView!.contentMode = UIViewContentMode.ScaleAspectFill
        expandView!.clipsToBounds = true
        reSizeView()
    }
    
    // 重置位置
    func reSizeView(){
        expandView!.frame = CGRectMake(0,  -HJImageTopHeight - (expandHeight - HJImageTopHeight - HJImageBottomHeight), CGRectGetWidth(expandView!.frame), expandHeight)
    }
    
    
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
            var offfsetY:CGFloat = scrollView!.contentOffset.y
        if keyPath != HJExpandContentOffset{
            return
        }
        scrollViewDidScroll(scrollView!)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 这里偏移量变成 200
        var offfsetY:CGFloat = scrollView.contentOffset.y
        println("偏移量" + String(stringInterpolationSegment: offfsetY))
        println(expandView!.frame)

        if offfsetY < (expandHeight * -1 + HJImageBottomHeight + HJImageTopHeight){
            
            println(expandView!.frame)
            var currentFrame:CGRect = expandView!.frame
            currentFrame.origin.y = offfsetY - HJImageTopHeight
            currentFrame.size.height = offfsetY * -1 + HJImageBottomHeight + HJImageTopHeight
            expandView!.frame  = currentFrame
            println(expandView!.frame)

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
