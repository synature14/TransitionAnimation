//
//  ItemDetailController.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var item: PastaModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset.bottom = 40
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width,
                                              height: UIScreen.main.bounds.height)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
    }

    @IBAction func dismissSelf(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    static func create() -> ItemDetailController {
        let sb = UIStoryboard(name: "ItemDetail", bundle: nil)
        return sb.instantiateViewController(identifier: "ItemDetailController") as! ItemDetailController
    }
}

extension ItemDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailCell", for: indexPath) as? ItemDetailCell {
            cell.setUI(item: item)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

