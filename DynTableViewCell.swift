//
//  DynTableViewCell.swift
//  DynTableView
//
//  Created by Afry on 16/1/29.
//  Copyright © 2016年 AfryMask. All rights reserved.
//

import UIKit
import Foundation


class DynTableViewCell: UITableViewCell {
    
    // 屏幕宽高
    
    let ScreenWidth = UIScreen.mainScreen().bounds.size.width
    let ScreenHeitht = UIScreen.mainScreen().bounds.size.height
    
    // 图片控件
    private var imgView = UIImageView()
    // 图片缩放后高度
    private var imgHeight:CGFloat = 0.0
    
    // 设置动态图片
    var dynImage:UIImage = UIImage() {
        didSet{
            // 约束view
            let backgroundView = UIView(frame: CGRectMake(10, 10, ScreenWidth-20, 180))
            
            // 图片缩放后理论宽度
            let imageWeight = backgroundView.frame.size.width
            // 图片缩放比
            let imagePro = dynImage.size.height/dynImage.size.width
            // 图片缩放后理论高度
            imgHeight = imageWeight * imagePro
            // 图片控件frame
            imgView.frame = CGRectMake(0, 0, imageWeight, imgHeight)
            // 设置控件的图片
            imgView.image = dynImage
            // 图片
            imgView.contentMode = .ScaleAspectFit
            // 图片缩放至控件大小（理论大小）
            backgroundView.clipsToBounds = true
            
            // 初始位置
            imgView.frame.origin.y = (imgHeight-frame.height)*(-150-frame.origin.y)/(ScreenHeitht-200)
            
            // 添加控件
            backgroundView.addSubview(imgView)
            addSubview(backgroundView)
        
        }
    
    }
    
    
    // KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        let position = object!.contentOffset.y
        imgView.frame.origin.y = (imgHeight-180)*(position-frame.origin.y)/(ScreenHeitht-200)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier!)
        backgroundColor = UIColor.lightGrayColor()
        
        // 选中时没有效果
        selectedBackgroundView! = UIView(frame: CGRectMake(0, 0, 0, 0))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 销毁监听
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
}
