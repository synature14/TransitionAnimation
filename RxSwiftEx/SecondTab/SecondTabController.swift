//
//  SecondTabController.swift
//  RxSwiftEx
//
//  Created by SutieDev on 12/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class SecondTabController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    static func create() -> SecondTabController {
        let sb = UIStoryboard(name: "SecondTab", bundle: nil)
        return sb.instantiateViewController(identifier: "SecondTabController") as! SecondTabController
    }

}
