//
//  SecondViewController.swift
//  SideMenu
//
//  Created by 승윤 on 06/04/2019.
//  Copyright © 2019 김승윤. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }//viewDIdLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Second View Controller Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Second View Controller Will Disappear")
    }
    
}//class
