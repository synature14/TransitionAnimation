
//
//  ShoppingMainController.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit
//import RxSwift

protocol ShoppingCartDelegate {
    func addToCart(id: String, count: Int)
}

class ShoppingMainController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    var items: [PastaModel]!
    var cartItems: [CartItem] = []
    let viewModel = ShoppingMainViewModel()
    
    var selectedIndexPath: IndexPath?
    
    let transition = TransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = PastaModel.getItems()
        self.navigationController?.navigationItem.title = "Pasta"
        
        if let layout = cartCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    static func create() -> ShoppingMainController {
        let sb = UIStoryboard(name: "ShoppingMain", bundle: nil)
        return sb.instantiateViewController(identifier: "ShoppingMainController") as! ShoppingMainController
    }
}

extension ShoppingMainController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == cartCollectionView {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cartCollectionView {
            if section == 0 {
                return 1
            } else {
                return cartItems.count
            }
        } else {
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cartCollectionView {
            let section = indexPath.section
            
            switch section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartTitleCell", for: indexPath) as! CartTitleCell
                return cell
            case 1:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartItemCell", for: indexPath) as? CartItemCell {
                    cell.setUI(cartItem: cartItems[indexPath.item])
                    return cell
                }
            default:
                return UICollectionViewCell()
            }
            
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell {
                cell.setUI(item: items[indexPath.item])
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}


extension ShoppingMainController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let vc = ItemDetailController.create()
            vc.item = items[indexPath.item]
            self.selectedIndexPath = indexPath
            vc.delegate = self
            vc.modalPresentationStyle = .fullScreen
            vc.transitioningDelegate = self

            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension ShoppingMainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 45)
    }
}


// MARK: - UIViewControllerTransitioningDelegate
extension ShoppingMainController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard
            let selectedIndexPath = selectedIndexPath,
            let cell = collectionView.cellForItem(at: selectedIndexPath) as? ItemCell else {
            return nil
        }
        transition.originFrame = cell.frame
        transition.selectedItem = items[selectedIndexPath.item]
        transition.isPresenting = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let _ = dismissed as? ItemDetailController {
            transition.isPresenting = false
            return transition
        }
        return nil
    }
}


extension ShoppingMainController: ShoppingCartDelegate {
    func addToCart(id: String, count: Int) {
        if let hasItem = cartItems.filter({ $0.id == id }).first {
            hasItem.count = count
        } else {
            let cartItem = CartItem(id: id, count: count)
            self.cartItems.append(cartItem)
        }
        
        cartCollectionView.reloadData()
    }
}
