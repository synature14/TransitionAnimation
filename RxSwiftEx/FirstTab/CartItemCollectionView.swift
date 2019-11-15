//
//  CartItemCollectionView.swift
//  RxSwiftEx
//
//  Created by SutieDev on 2019/11/15.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class CartItemCollectionView: UICollectionView {

    var reloadDataCompletionBlock: (() -> Void)?
    func reloadDataWithCompletion(_ completion:@escaping () -> Void) {
        reloadDataCompletionBlock = completion
        super.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print("---- layoutSubviews() -----\n")
        if let block = self.reloadDataCompletionBlock {
            print("\n****** Execute Blocking *****")
            block()
        }
    }
}
