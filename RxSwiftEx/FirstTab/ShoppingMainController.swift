
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
    func addToCart(id: String, count: Int, itemImageViewBounds: CGRect)
    func dismiss(_ bool: Bool)
}

class ShoppingMainController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartCollectionView: CartItemCollectionView!
    
    
    var items: [PastaModel]!
    var cartItems: [CartItem] = []
    let viewModel = ShoppingMainViewModel()
    
    var selectedIndexPath: IndexPath?
    
    let transition = TransitionAnimator()
    var itemDetailVCImageViewFrame: CGRect = .zero
    var cartCollectionViewLineSpacing: CGFloat = 0.0
    var itemImageViewBounds: CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = PastaModel.getItems()
        self.navigationController?.navigationItem.title = "Pasta"
        
        if let layout = cartCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            self.cartCollectionViewLineSpacing = layout.minimumLineSpacing
        }
    }
    
    static func create() -> ShoppingMainController {
        let sb = UIStoryboard(name: "ShoppingMain", bundle: nil)
        return sb.instantiateViewController(identifier: "ShoppingMainController") as! ShoppingMainController
    }
}

extension ShoppingMainController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cartCollectionView {
            return cartItems.count
        } else {
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cartCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartItemCell", for: indexPath) as? CartItemCell {
                cell.setUI(cartItem: cartItems[indexPath.item])
                return cell
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
            
            let lastIndexPath = IndexPath(item: cartItems.count - 1, section: 0)
            guard let cell = cartCollectionView.cellForItem(at: lastIndexPath) as? CartItemCell else {
                return nil
            }
            
            transition.originFrame = itemImageViewBounds
            transition.destinationCartCellFrame = cell.convert(cell.bounds, to: self.view)
            transition.isPresenting = false
            return transition
        }
        return nil
    }
}


extension ShoppingMainController: ShoppingCartDelegate {
    func dismiss(_ bool: Bool) {
        let itemVC = self.presentedViewController as? ItemDetailController
        itemVC?.dismiss(animated: true)
    }
    
    func addToCart(id: String, count: Int, itemImageViewBounds: CGRect) {
        if let hasItem = cartItems.filter({ $0.id == id }).first {
            hasItem.count = count
        } else {
            let cartItem = CartItem(id: id, count: count)
            self.cartItems.append(cartItem)
        }
        self.itemImageViewBounds = itemImageViewBounds
        cartCollectionView.reloadDataWithCompletion {
            print("[[[[[[[[  cartCollectionView RELOAD Data Completion..   ]]]]]]")
        }
    }
}
