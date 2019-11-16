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
    var delegate: ShoppingCartDelegate?
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var textContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var explainTextView: UITextView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.value = 1.0
        itemImageView.image = item.image
        titleLabel.text = item.title
        weightLabel.text = item.weight
        priceLabel.text = item.price
        explainTextView.text = item.explain
        
        textContainerView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height - textContainerView.frame.height + 20)
        textContainerView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.textContainerView.alpha = 1
        })
        
        UIView.animateKeyframes(withDuration: 1.5,
                                delay: 0,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                                        self.textContainerView.transform = .identity
                                    })
        })
    }

    @IBAction func stepperTapped(_ sender: Any) {
        let stepper = sender as! UIStepper
        amountLabel.text = String(Int(stepper.value))
    }
    
    @IBAction func addToCart(_ sender: Any) {
        delegate?.addToCart(id: item.id, count: Int(stepper.value), itemImageViewFrame: itemImageView.frame)
        dismiss(animated: true)
    }
    
    @IBAction func dismissSelf(_ sender: Any) {
        self.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        dismiss(animated: true)
    }
    
    static func create() -> ItemDetailController {
        let sb = UIStoryboard(name: "ItemDetail", bundle: nil)
        return sb.instantiateViewController(identifier: "ItemDetailController") as! ItemDetailController
    }
}
