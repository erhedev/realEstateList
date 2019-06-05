//
//  PropertyCell.swift
//  realEstateList
//
//  Created by Erik Hede on 02/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class PropertyCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var propertyImageView: UIImageView!
    let starButton = FavStarButton(type: .system)
    var id: String = ""
    var cellBag = DisposeBag()
    var isOn: Bool = false
    var indexPath: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1))
        propertyImageView.contentMode = .scaleAspectFill
        propertyImageView.clipsToBounds = true
        accessoryView = starButton
        prepareStarButton()
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if (selected) {
//            self.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
//        } else {
//            self.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1))
//        }
//    }
    
    func loadImageFromURL(url: String) {
        propertyImageView.sd_setImage(with: URL(string: url), placeholderImage: nil)
    }
    
//    func createButton () {
//        let starButton = FavStarButton(type: .system)
//
//    }
    
    func prepareStarButton() {
        starButton.rx.tap
            .subscribe({ [weak self] _ in
                print(self?.id)
                self?.buttonPressed()
            })
            .disposed(by: cellBag)
    }

    func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        self.isOn = bool
        let color = bool ? UIColor.init(cgColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)) : UIColor.init(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        starButton.tintColor = color
  
        guard let id = Int(self.id) else { return }
        
        if isOn {
            Utility.Instance.favIDs.append(id)
            Utility.Instance.checkedCells.append(self.indexPath)
        }else{
            // remove unchecked cell from list
            if let index = Utility.Instance.checkedCells.firstIndex(of: self.indexPath){
                Utility.Instance.checkedCells.remove(at: index)
            }
            if let fav = Utility.Instance.favIDs.firstIndex(of: id) {
                Utility.Instance.favIDs.remove(at: fav)
            }
        }
    }
}

