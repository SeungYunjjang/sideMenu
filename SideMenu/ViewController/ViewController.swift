//
//  ViewController.swift
//  SideMenu
//
//  Created by 승윤 on 06/04/2019.
//  Copyright © 2019 김승윤. All rights reserved.
//

import UIKit

class ViewController: UIViewController, showMainContainerViewDelegate {
    
    @IBOutlet var sideMenuContainerView: UIView!
    @IBOutlet var sideMenuFrameStackView: UIStackView!
    @IBOutlet var mainContainerView: UIView!
    
    var isSideOn: Bool = true
    var originStackViewCGPoint: CGPoint = CGPoint(x: 0, y: 0)
    var vcArray: Array<UIViewController> = []

    fileprivate let SHOW_SIDE_MENU = "show_side_menu"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let firstVC = sb.instantiateViewController(withIdentifier: "FirstVC") as? FirstViewController,
            let secondVC = sb.instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController,
        let thirdVC = sb.instantiateViewController(withIdentifier: "ThirdVC") as? ThirdViewController {
            vcArray.append(firstVC)
            vcArray.append(secondVC)
            vcArray.append(thirdVC)
        }
        //container Add first viewcontroller
        containerViewRemoveAll()
        containerViewAdd(vcArray[0])
    }//viewDidLoad
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case SHOW_SIDE_MENU:
            if let sideMenuVC = segue.destination as? SideMenuViewController {
                sideMenuVC.showMainListDelegate = self
            }
        default:
            break
        }
    }//prepare
    
    @IBAction func showSideMenuBtn(_ sender: UIButton) {
        if sideMenuFrameStackView.isHidden {
            sideMenuFrameStackView.isHidden = false
            sideMenuAnimate(v: sideMenuContainerView, isHidden: false)
            
            isSideOn = false
        } else {
            sideMenuAnimate(v: sideMenuContainerView, isHidden: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.sideMenuFrameStackView.isHidden = true
            }
            isSideOn = true
        }
        originStackViewCGPoint = sideMenuFrameStackView.center
    }//showSideMenuBtn
    
    @IBAction func edgeGesture(_ sender: UIScreenEdgePanGestureRecognizer) {

        if isSideOn {
            self.sideMenuFrameStackView.isHidden = false
            sideMenuAnimate(v: sideMenuContainerView, isHidden: false)
            originStackViewCGPoint = sideMenuFrameStackView.center
            isSideOn = false
        }
    }//edgeGesture
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        
        if !isSideOn {
            sideMenuAnimate(v: sideMenuContainerView, isHidden: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.sideMenuFrameStackView.isHidden = true
            }
            isSideOn = true
        }
    }//tapGesture
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        
        let velocity = sender.velocity(in: sideMenuFrameStackView)
        let translation = sender.translation(in: sideMenuFrameStackView)
        let changeX = sideMenuFrameStackView.center.x + translation.x
        
        sender.cancelsTouchesInView = false
        
        if abs(velocity.x) > abs(velocity.y) {
            
            if velocity.x < 0 {
                //left swipe
                sideMenuFrameStackView.center = CGPoint(x:changeX, y: sideMenuFrameStackView.center.y)
                sender.setTranslation(CGPoint.zero, in: sideMenuFrameStackView)
                
            } else if velocity.x > 0 {
                //right swipe
                if sideMenuFrameStackView.center.x < view.center.x {
                    sideMenuFrameStackView.center = CGPoint(x:changeX, y: sideMenuFrameStackView.center.y)
                    sender.setTranslation(CGPoint.zero, in: sideMenuFrameStackView)
                    
                } else {
                    sideMenuFrameStackView.center = CGPoint(x:view.center.x, y: sideMenuFrameStackView.center.y)
                    sender.setTranslation(CGPoint.zero, in: sideMenuFrameStackView)
                }
            }
        }//left and right
        
        if sender.state == .ended {
            
            if sideMenuFrameStackView.center.x < 0 {
                sideMenuAnimate(v: sideMenuContainerView, isHidden: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.sideMenuFrameStackView.isHidden = true
                }
                isSideOn = true
            }
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: .transitionFlipFromLeft,
                animations: {
                    self.sideMenuFrameStackView.center = self.originStackViewCGPoint
                    self.view.layoutIfNeeded()
            }, completion: nil)
        }//sender.state == .ended
        
    }//panGesture
    
    func sideMenuAnimate(v: UIView, isHidden: Bool) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 1,
            options: .transitionFlipFromLeft,
            animations: {
                self.sideMenuContainerView.isHidden = isHidden
                self.sideMenuFrameStackView.layoutIfNeeded()
        }, completion: nil)
    }//sideMenuAnimate
    
    func showContainerView(_ num: Int) {
        containerViewRemoveAll()
        containerViewAdd(vcArray[num])
        //hide sideMenu
        if !isSideOn {
            sideMenuAnimate(v: sideMenuContainerView, isHidden: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.sideMenuFrameStackView.isHidden = true
            }
            isSideOn = true
        }
    }//showContainerView
    
    private func containerViewAdd(_ vc: UIViewController) {
        
        addChild(vc)
        mainContainerView.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vc.view.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            vc.view.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor)
            ])
        vc.didMove(toParent: self)
    }//containerViewAdd
    
    private func containerViewRemoveAll() {
        for viewController in vcArray {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
    }//containerViewRemoveAll
    
}//class


