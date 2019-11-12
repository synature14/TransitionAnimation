//
//  RootViewController.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    
    @IBOutlet weak var embedView: UIView!
    
    var firstTab = ShoppingMainController.create()
    var secondTab = SecondTabController.create()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(firstTab)
        firstTab.view.frame = CGRect(x: 0, y: 0,
                                     width: self.view.frame.width,
                                     height: embedView.frame.height)
        firstTab.view.layoutSubviews()
        firstTab.collectionView.layoutIfNeeded()
        self.embedView.addSubview(firstTab.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstTab.didMove(toParent: self)
    }

    @IBAction func firstTabTapped(_ sender: Any) {
        if self.children.contains(secondTab) {
            self.willMove(toParent: nil)
            secondTab.view.removeFromSuperview()
            secondTab.removeFromParent()
            
            addChild(firstTab)
            firstTab.view.frame = CGRect(x: 0, y: 0,
                                         width: self.view.frame.width,
                                         height: embedView.frame.height)
            self.embedView.addSubview(firstTab.view)
            firstTab.didMove(toParent: self)
        }
       
    }
    
    @IBAction func secondTabTapped(_ sender: Any) {
        if self.children.contains(firstTab) {
            self.willMove(toParent: nil)
            firstTab.view.removeFromSuperview()
            firstTab.removeFromParent()
            
            addChild(secondTab)
            secondTab.view.frame = CGRect(x: 0, y: 0,
                                          width: self.view.frame.width,
                                          height: embedView.frame.height)
            self.embedView.addSubview(secondTab.view)
            secondTab.didMove(toParent: self)
        }
    }
}

