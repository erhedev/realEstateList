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
    
    private var localStorageService = LocalStorageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let favs = fetchFavourites() {
            Utility.Instance.favIDs = favs
            print(favs)
        }
        
        populateProprerties()
        propertiesTableView.register(UINib.init(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.propertiesTableView.reloadData()
    }
    
    private func populateProprerties() {
        
        let resource = Resource<PropertyResponse>(url: URL(string: "https://www.booli.se/public/search-results.json")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { propertyResponse in
                let properties = propertyResponse.results
                Utility.Instance.propertyListViewModel = PropertyListViewModel(properties)
                DispatchQueue.main.async {
                    self.propertiesTableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchFavourites() -> [Int]? {
        let favourites: [Int]
        if let favs = localStorageService.fetchFavourites() {
            favourites = favs
            return favourites
        }
        return nil
    }
    
}

extension PropertyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Utility.Instance.propertyListViewModel == nil ? 0: Utility.Instance.propertyListViewModel.propertyViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath) as? PropertyCell else {
            fatalError("PropertyCell not found")
        }
        
        cell.indexPath = indexPath.row
        
        var checkedCells = Utility.Instance.checkedCells
        
        let propertyViewModel = Utility.Instance.propertyListViewModel.propertyAt(indexPath.row)
        
        propertyViewModel.isOn.subscribe(onNext: { value in
            print(value)
            if checkedCells.contains(indexPath.row){
                print(Utility.Instance.propertyListViewModel.propertyAt(indexPath.row))
                cell.activateButton(bool: value)
            } else {cell.activateButton(bool: value)}
        })
        
        propertyViewModel.thumbNailURL.subscribe(onNext: { element in
            print(element)
            cell.loadImageFromURL(url: element)
        }).disposed(by: disposeBag)
        
        propertyViewModel.id.subscribe(onNext: { element in
            print(element)
            
            if let savedIds = self.fetchFavourites() {
                if savedIds.contains(element) {
                    cell.activateButton(bool: true)
                    Utility.Instance.propertyListViewModel.setPropertyVmFavAt(cell.indexPath, bool: true)
                }
            }
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
