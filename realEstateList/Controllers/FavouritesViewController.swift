//
//  FavouritesViewController.swift
//  realEstateList
//
//  Created by Erik Hede on 29/05/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation


import UIKit
import RxSwift
import RxCocoa

class FavouritesViewController: UIViewController {
  
    @IBOutlet weak var favTableView: UITableView!
    
    let disposeBag = DisposeBag()
    private var favListViewModel: PropertyListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.register(UINib.init(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        favListViewModel = PropertyListViewModel(Utility.Instance.propertyListViewModel.getFavourites())
        self.favTableView.reloadData()
    }
    
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favListViewModel == nil ? 0: self.favListViewModel.propertyViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath) as? PropertyCell else {
            fatalError("PropertyCell not found")
        }
        
        cell.indexPath = indexPath.row
        let checkedCells = Utility.Instance.checkedCells
        let propertyViewModel = self.favListViewModel.propertyAt(indexPath.row)
        
        propertyViewModel.isOn.subscribe(onNext: { value in
            print(value)
            if checkedCells.contains(indexPath.row){
                cell.activateButton(bool: true)
            } else {cell.activateButton(bool: value)}
        })
        
        propertyViewModel.thumbNailURL.subscribe(onNext: { element in
            print(element)
            cell.loadImageFromURL(url: element)
        }).disposed(by: disposeBag)
        
        propertyViewModel.id.subscribe(onNext: { element in
            print(element)
            cell.id = String(element)
        }).disposed(by: disposeBag)
        
        propertyViewModel.address.asDriver(onErrorJustReturn: "")
            .drive(cell.addressLabel.rx.text)
            .disposed(by: disposeBag)
        
        propertyViewModel.price.asDriver(onErrorJustReturn: "")
            .drive(cell.priceLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
        
    }
}

