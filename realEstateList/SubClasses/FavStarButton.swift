//
//  FavStarButton.swift
//  realEstateList
//
//  Created by Erik Hede on 04/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavStarButton: UIButton {
    
    var isOn: Bool = false
    var buttonBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        self.setImage(UIImage.init(imageLiteralResourceName: "icons8-star-30"), for: .normal)
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.tintColor = UIColor.init(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
    
}
