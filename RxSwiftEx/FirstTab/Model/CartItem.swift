//
//  File.swift
//  RxSwiftEx
//
//  Created by SutieDev on 2019/11/13.
//  Copyright © 2019 developers. All rights reserved.
//

import Foundation

class CartItem {
    var id: String = ""
    var item: PastaModel!
    var count: Int = 0
    
    init(id: String, count: Int) {
        self.id = id
        self.item = self.getItem(of: id)
        self.count = count
    }
    
    func getItem(of id: String) -> PastaModel {
        let items = PastaModel.getItems()
        return items.filter { $0.id == id }.first!
    }
}
