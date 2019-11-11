//
//  ItemDetailController.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {
    var item: PastaModel!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissSelf(_ sender: Any) {
        dismiss(animated: true)
    }
    
    static func create() -> ItemDetailController {
        let sb = UIStoryboard(name: "ItemDetail", bundle: nil)
        return sb.instantiateViewController(identifier: "ItemDetailController") as! ItemDetailController
    }
}
