//
//  FirstViewController.swift
//  SideMenu
//
//  Created by 승윤 on 06/04/2019.
//  Copyright © 2019 김승윤. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }//viewDIdLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("First View Controller Will Appear")
    }//viewWillAppear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("First View Controller Will Disappear")
    }//viewWillDisappear
    

    
    
}//class
