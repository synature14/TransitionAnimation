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
    
    @IBOutlet weak var textContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var explainTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemImageView.image = item.image
        titleLabel.text = item.title
        weightLabel.text = item.weight
        priceLabel.text = item.price
        explainTextView.text = item.explain
        
        textContainerView.transform = CGAffineTransform(translationX: 0, y: textContainerView.frame.height)
        textContainerView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.2, delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        
                        self.textContainerView.transform = .identity
                        self.textContainerView.alpha = 1
                        
        })
    }

    @IBAction func dismissSelf(_ sender: Any) {
        dismiss(animated: true)
    }
    
    static func create() -> ItemDetailController {
        let sb = UIStoryboard(name: "ItemDetail", bundle: nil)
        return sb.instantiateViewController(identifier: "ItemDetailController") as! ItemDetailController
    }
}
