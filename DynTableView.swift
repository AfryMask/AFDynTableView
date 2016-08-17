//
//  DynTableView.swift
//  DynTableView
//
//  Created by Afry on 16/1/29.
//  Copyright © 2016年 AfryMask. All rights reserved.
//

import UIKit

class DynTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    // 显示图片的控制器
    var headerView = UIImageView()
    // 图片
    let img = UIImage(named: "header")!
    // 初始化图片宽高
    var headerWidth:CGFloat = 0.0
    var headerHeight:CGFloat = 0.0
    var widthHeightPro:CGFloat = 1.0
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        
        registerClass(DynTableViewCell.self, forCellReuseIdentifier: "cell")
        dataSource = self
        delegate = self
        // cell间隔线条
        separatorStyle = .None
        
        contentInset = UIEdgeInsetsMake(150, 0, 0, 0)
        
        // 图片控制器的真实大小
       
        
        headerWidth = frame.width
        headerHeight = img.size.height/img.size.width*frame.width
        widthHeightPro = headerWidth/headerHeight
        
        headerView.frame = CGRectMake(0, 0, headerWidth, headerHeight)
        headerView.contentMode = .ScaleToFill
        
        headerView.center = CGPointMake(frame.width/2, -75)
        
        headerView.image = img
        
        
        addSubview(headerView)
        
        
        sendSubviewToBack(headerView)
        
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DynTableViewCell
        cell.dynImage = UIImage(named: "\(indexPath.item)")!

        cell.tag = indexPath.item
        addObserver(cell, forKeyPath: "contentOffset", options: .New, context: nil)
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        if -contentOffset.y > UIScreen.mainScreen().bounds.size.height/2 {
            contentOffset.y = -UIScreen.mainScreen().bounds.size.height/2
        }
        
        
        var currentHeight = headerHeight-contentOffset.y-150
        
        
        currentHeight = currentHeight > headerHeight ? currentHeight : headerHeight
        
        headerView.frame = CGRectMake(0, 0, currentHeight*widthHeightPro, currentHeight)
        
        headerView.center = CGPointMake(frame.width/2, scrollView.contentOffset.y/2)
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.backgroundColor = UIColor.redColor()
        print("123")
        
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    
    
    
}
