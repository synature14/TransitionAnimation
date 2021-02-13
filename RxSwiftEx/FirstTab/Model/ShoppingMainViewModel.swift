//
//  ShoppingMainViewModel.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import RxSwift
import RxCocoa

class ShoppingMainViewModel {
    enum ViewAction {
        case showItemDetail(pastaModel: PastaModel)
    }
    
    let viewAction = PublishSubject<ViewAction>()
    let disposeBag = DisposeBag()
    
    init() {
        bindItems()
    }
    
    
}

extension ShoppingMainViewModel {
    func bindItems() {
        
    }
}
