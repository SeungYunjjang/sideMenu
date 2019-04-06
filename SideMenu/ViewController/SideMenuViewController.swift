//
//  SideMenuViewController.swift
//  SideMenu
//
//  Created by 승윤 on 06/04/2019.
//  Copyright © 2019 김승윤. All rights reserved.
//

import UIKit

protocol showMainContainerViewDelegate {
    func showContainerView(_ num: Int)
}

class SideMenuViewController: UIViewController {
    
    public var showMainListDelegate: showMainContainerViewDelegate?
    
    override func viewDidLoad() {
        
    }//viewDIdLoad
    
    @IBAction func menuListBtn(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            showMainListDelegate?.showContainerView(sender.tag)
        case 1:
            showMainListDelegate?.showContainerView(sender.tag)
        case 2:
            showMainListDelegate?.showContainerView(sender.tag)
        default:
            break
        }
    }//menuListBtn
    
    
}//class
