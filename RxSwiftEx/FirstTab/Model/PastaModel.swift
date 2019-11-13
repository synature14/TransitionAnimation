//
//  PastaModel.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import Foundation
import UIKit

class PastaModel {
    let id: String
    let image: UIImage
    let title: String
    let price: String
    let weight: String
    let explain: String
    
    init(id: String, image: UIImage, title: String, price: String, weight: String, explain: String) {
        self.id = id
        self.image = image
        self.title = title
        self.price = price
        self.weight = weight
        self.explain = explain
    }
    
    static func getItems() -> [PastaModel] {
        let ex01 = PastaModel(id: "A0001",
                              image: UIImage(named: "barilla")!,
                              title: "Barilla Spagetti",
                              price: "$7.29",
                              weight: "500g",
                              explain: "Cook and eat right from the convenient pouch. Tasty blend of tender rotini pasta, creamy Alfredo sauce and black pepper. No added preservatives, artificial flavors or colors in a Non-BPA pouch. wheat gluten, digestive-resistant cornstarch,")
        
        let ex02 = PastaModel(id: "A0002",
                              image: UIImage(named: "classico")!,
                              title: "Classico Noodles",
                              price: "$9.51",
                              weight: "350g",
                              explain: "Barilla Gluten Free Elbows are made with Non-GMO corn & rice and is certified Gluten Free pasta.\nCook Time: 7 minutes for perfectly al dente pasta with fantastic gluten free macaroni taste. Serving Size: 6 per box, perfect for a large family hungry for gluten free pasta.\n Elbow macaroni, also known as \"Gomati\" in Italian, is named for its twisted, tubular pasta shape. Elbow pasta is perfect for macaroni & cheese, pasta salad or baked pasta dishes")
        
        let ex03 = PastaModel(id: "A0003",
                              image: UIImage(named: "eggNoodles")!,
                              title: "EggNoodles",
                              price: "$11.52",
                              weight: "1kg",
                              explain: "Case of six 10-ounce bags (total of 60 ounces). Low-carb, all-natural, hand-crafted roasted-garlic egg fettuccine; 18 net grams carb per serving. Made of semolina flour, defatted soy flour, wheat gluten, digestive-resistant cornstarch, whole eggs")
        
        let ex04 = PastaModel(id: "A0004",
                              image: UIImage(named: "fettuccine")!,
                              title: "Fettuccine",
                              price: "$11.52",
                              weight: "480g",
                              explain: "Perfect size to feed the whole family. Pairs well with chicken broth, tomato sauce, melted butter or olive oil with Parmesan cheese")
        
        let ex05 = PastaModel(id: "A0005",
                              image: UIImage(named: "hunts")!,
                              title: "Tomato Sauce",
                              price: "$11.52",
                              weight: "500g",
                              explain: "Barilla ProteinPLUS Rotini is a nutritious multigrain spiral pasta with protein for your diet. This high protein spiral pasta is verified non-GMO, kosher certified & a product of the USA. Our ProteinPLUS rotini pasta is fortified with protein, iron & Omega 3s for proven nutrition")
        
        let ex06 = PastaModel(id: "A0006",
                              image: UIImage(named: "prego")!,
                              title: "[Prego] Rose sauce - Pasta, Risotto",
                              price: "$11.52",
                              weight: "150g",
                              explain: "All you need is a fork, a minute and a microwave. Heat and eat—perfect for your busy lifestyle, Comes with ONE 8 oz. package of each pasta type.\n* Low carb, all natural. \n* Non GMO and Kosher.\nLoaded with fiber.\n* 7g Net Carbs, 12g of Protein")
        
        let ex07 = PastaModel(id: "A0007",
                              image: UIImage(named: "senza")!,
                              title: "[Senza] Cream sauce - Pasta, Risotto",
                              price: "$18.03",
                              weight: "400g",
                              explain: "100% Satisfaction guaranteed. If you are not satisfied with your order, contact us directly for a full refund.")
        
        return [ex01, ex02, ex03, ex04, ex05, ex06, ex07]
        
    }
}

