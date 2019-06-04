//
//  ViewController.swift
//  realEstateList
//
//  Created by Erik Hede on 29/05/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PropertyListViewController: UIViewController {
    
    @IBOutlet weak var propertiesTableView: UITableView!
  
    let disposeBag = DisposeBag()
    private var propertyListViewModel: PropertyListViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateProprerties()
        
        propertiesTableView.register(UINib.init(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")
        
    }
    
    private func populateProprerties() {
        
        let resource = Resource<PropertyResponse>(url: URL(string: "https://www.booli.se/public/search-results.json")!)
        
        URLRequest.load(resource: resource)
                .subscribe(onNext: { propertyResponse in
                
                print(propertyResponse)
                let properties = propertyResponse.results
                print(properties)
                self.propertyListViewModel = PropertyListViewModel(properties)
                DispatchQueue.main.async {
                    self.propertiesTableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
}

extension PropertyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propertyListViewModel == nil ? 0: self.propertyListViewModel.propertyViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath) as? PropertyCell else {
            fatalError("PropertyCell not found")
        }
        
        let propertyViewModel = self.propertyListViewModel.propertyAt(indexPath.row)
        
        propertyViewModel.thumbNailURL.subscribe(onNext: { element in
            print(element)
            cell.loadImageFromURL(url: element)
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

