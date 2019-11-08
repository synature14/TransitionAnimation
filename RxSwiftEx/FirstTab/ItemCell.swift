//
//  ItemCell.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    func setUI(item: PastaModel) {
        self.imageView.image = item.image
        self.priceLabel.text = item.price
        self.itemTitleLabel.text = item.title
        self.weightLabel.text = item.weight
    }
}
