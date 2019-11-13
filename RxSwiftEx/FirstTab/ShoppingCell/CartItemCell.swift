
//
//  CartItemCell.swift
//  RxSwiftEx
//
//  Created by SutieDev on 2019/11/13.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class CartItemCell: UICollectionViewCell {
    
    @IBOutlet weak var cartImageView: UIImageView!
    
    func setUI(cartItem: CartItem) {
        cartImageView.image = cartItem.item.image
        print("cartItem : \(cartItem.item.title)")
        print("cartItem Count : \(cartItem.count)")
    }
}
