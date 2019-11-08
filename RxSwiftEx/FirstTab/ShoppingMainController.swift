
//
//  ShoppingMainController.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit
//import RxSwift

class ShoppingMainController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [PastaModel]!
    let viewModel = ShoppingMainViewModel()
    
    var selectedIndexPath: IndexPath?
    
    let presentAnimator = PresentAnimator()
    let dismissAnimator = DismissAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = PastaModel.getItems()
        self.navigationController?.navigationItem.title = "Pasta"
        
    }
}

extension ShoppingMainController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell {
            cell.setUI(item: items[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ShoppingMainController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemDetailController.create()
        vc.item = items[indexPath.item]
        self.selectedIndexPath = indexPath
        vc.transitioningDelegate = self

        self.present(vc, animated: true, completion: nil)
    }
}


// MARK: - UIViewControllerTransitioningDelegate
extension ShoppingMainController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let `selectedIndexPath` = selectedIndexPath,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? ItemCell,
            let selectedCellSuperview = selectedCell.superview else {
                return nil
        }
        presentAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        presentAnimator.originFrame = CGRect(x: presentAnimator.originFrame.origin.x + 20,
                                        y: presentAnimator.originFrame.origin.y + 20,
                                        width: presentAnimator.originFrame.size.width - 40,
                                        height: presentAnimator.originFrame.size.height - 40)
        
        presentAnimator.isPresenting = true
        return presentAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let _ = dismissed as? ItemDetailController {
            return dismissAnimator
        }
        return nil
    }
}
