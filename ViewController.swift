//
//  ViewController.swift
//  DynTableView
//
//  Created by Afry on 16/1/29.
//  Copyright © 2016年 AfryMask. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vie = DynTableView(frame: view.frame, style: .Plain)
        view.addSubview(vie)
        
        
        
        
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    


}

