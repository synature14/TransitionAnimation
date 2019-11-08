//
//  ItemDetailCell.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class ItemDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var explainTextView: UITextView!
    
    
    func setUI(item: PastaModel) {
        self.itemImageView.image = item.image
        self.weightLabel.text = item.weight
        self.priceLabel.text = item.price
        self.explainTextView.text = item.explain
    }
    
}

extension ItemDetailCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
      animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesCancelled(touches, with: event)
      animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseOut]
      if isHighlighted {
        UIView.animate(withDuration: 0.4, delay: 0,
                       usingSpringWithDamping: 0,
                       initialSpringVelocity: 0.3,
                       options: animationOptions,
                       animations: {
                        self.transform = .init(scaleX: 0.95, y: 0.95)
        }, completion: completion)
        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.transform = .init(scaleX: 0.95, y: 0.95)
//        }, completion: completion)
      } else {
        UIView.animate(withDuration: 0.4, delay: 0,
                       usingSpringWithDamping: 0,
                       initialSpringVelocity: 0.3,
                       options: animationOptions,
                       animations: {
                        self.transform = .identity
        }, completion: completion)
        }
    }
}

