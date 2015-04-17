//
//  HJHomeTableViewCell.swift
//  HJKnowDaily
//
//  Created by 研究院01 on 15/4/17.
//  Copyright (c) 2015年 Loser. All rights reserved.
//

import UIKit
import Foundation
class HJHomeTableViewCell: UITableViewCell {
    
    let kleftwidth:CGFloat = 5
    let ktophighte:CGFloat = 10
    let kimagewidth:CGFloat = 90
    let kcellheight:CGFloat = 90
    
    
    var title:UILabel = UILabel()
    var rightImageView:UIImageView = UIImageView()
    var category:UILabel = UILabel()
    var type:String = "1"
        {
            willSet{
                    setUIType1()
            }
            didSet{
                if type == "1"{
                    setUIType1()
                }else if type == "2"{
                    setUIType2()
                }else if type == "3"{
                    setUIType3()
                }
            }
            
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func setUI(){
        title.frame = CGRectMake(kleftwidth, ktophighte, Utility.kWidth - kimagewidth - 2 * kleftwidth, kcellheight - ktophighte * 2)
        title.numberOfLines = 2
        title.textAlignment = NSTextAlignment.Left
        title.font = Utility.titleFont
        contentView.addSubview(title)
        
        rightImageView.frame = CGRectMake(Utility.kWidth - kimagewidth - 2 * kleftwidth, ktophighte, kimagewidth, kcellheight - ktophighte * 2)
        rightImageView.backgroundColor = UIColor.redColor()
        contentView.addSubview(rightImageView)
        
        category.font = Utility.categoryFont
        contentView.addSubview(category)
        
        
    }
    
    
    func setUIType1(){
        title.frame = CGRectMake(kleftwidth, ktophighte, Utility.kWidth - kimagewidth - 2 * kleftwidth, kcellheight - ktophighte * 2)
        rightImageView.frame = CGRectMake(Utility.kWidth - kimagewidth - 2 * kleftwidth, ktophighte, kimagewidth, kcellheight - ktophighte * 2)
        imageView?.backgroundColor = UIColor.redColor()
    }
    
    func setUIType2(){
        title.frame = CGRectMake(kleftwidth, ktophighte, Utility.kWidth - kimagewidth - 2 * kleftwidth, kcellheight - ktophighte * 2)
        rightImageView.frame = CGRectMake(Utility.kWidth - kimagewidth - 2 * kleftwidth, ktophighte, kimagewidth, kcellheight - ktophighte * 2)
        
    }
    
    func setUIType3(){
        title.frame = CGRectMake(kleftwidth, ktophighte, Utility.kWidth - kimagewidth - 2 * kleftwidth, kcellheight - ktophighte * 2)
        rightImageView.frame = CGRectMake(Utility.kWidth - kimagewidth - 2 * kleftwidth, ktophighte, kimagewidth, kcellheight - ktophighte * 2)

    }
    
    func heightForStr(text:String,width:CGFloat)->CGRect{
        UIFont.systemFontOfSize(13)
        let size = CGSize(width: width, height: CGFloat.max)
        let options : NSStringDrawingOptions = .UsesLineFragmentOrigin
        let attributes = [NSFontAttributeName:Utility.titleFont]
        let boundingRect = text.boundingRectWithSize(size, options: options, attributes: attributes, context: nil)
        return boundingRect
    }
    //MARK -
    
    /*
    [attrStr addAttribute:NSFontAttributeName
    value:[UIFont systemFontOfSize:13.0]
    range:allRange];
    [attrStr addAttribute:NSForegroundColorAttributeName
    value:[UIColor blackColor]
    range:allRange];
    
    NSRange destRange = [fullDescAndTagStr rangeOfString:tagStr];
    [attrStr addAttribute:NSForegroundColorAttributeName
    value:HEXCOLOR(0x009cdd)
    range:destRange];
    
    */
}
