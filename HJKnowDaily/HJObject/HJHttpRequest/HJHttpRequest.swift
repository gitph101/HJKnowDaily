//
//  HJHttpRequest.swift
//  HJKnowDaily
//
//  Created by 研究院01 on 15/4/16.
//  Copyright (c) 2015年 Loser. All rights reserved.
//

import UIKit
import Alamofire

class HJHttpRequest: NSObject {
    func urlRequest(){
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/start-image/1080*1776").responseJSON() {
            (_, _, data, error) in
            println(data)
            println(error)
        }
        // 这里类型推断。实际上写法应该是 let ion:any
        Alamofire.request(.GET,"http://news-at.zhihu.com/api/4/start-image/1080*1776").responseJSON(options: NSJSONReadingOptions.AllowFragments) { (_, _, ion, error) -> Void in return
            println("A")
            
        }
        
        
        /*
        调用Getlist 说明
        第一个参数 整形数组 [1,2,3,4]
        第二个参数  闭包 来指向给 函数类型 。
        {(s) in return s>2} 闭包类型说明，参数为整形,返回值为布尔类型
        */
        let arr = GetList([1,2,3,4],pre: {(s) in return
            s>2
        })
        println(arr)
        
    }
    
    
    
//    func urlRequest(url:String,success:(Any)->Void,fail:()->Void){
//        Alamofire.request(.GET,"http://news-at.zhihu.com/api/4/start-image/1080*1776").responseJSON(options: NSJSONReadingOptions.AllowFragments) { (_, _, data, error) -> Void in return
//            if 1 > 2 {
//                fail()
//            }else {
//                success(data)
//            }
//            
//        }
//    }
    
    func urlRequest(url:String,success:(Any,Any)->Void){
        Alamofire.request(.GET,url).responseJSON(options: NSJSONReadingOptions.AllowFragments) { (_, _, data, error) -> Void in return
            success(data,error)
        }
    }
    
    
    func GetList(arr:[Int] , pre:(Int)->Bool) ->[Int]{
        
        //定义一个空的可变整形集合
        var tempArr = [Int]()
        
        for temp in arr {
            
            if pre(temp){
                tempArr.append(temp)
            }
        }
        
        return tempArr;
    }

}


