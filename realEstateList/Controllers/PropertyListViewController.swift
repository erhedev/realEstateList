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
//    private var propertyListViewModel: PropertyListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateProprerties()
        
        propertiesTableView.register(UINib.init(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        self.propertiesTableView.reloadData()
    }
    
    private func populateProprerties() {
        
        let resource = Resource<PropertyResponse>(url: URL(string: "https://www.booli.se/public/search-results.json")!)
        
        URLRequest.load(resource: resource)
                .subscribe(onNext: { propertyResponse in
                
                print(propertyResponse)
                let properties = propertyResponse.results
                print(properties)
                Utility.Instance.propertyListViewModel = PropertyListViewModel(properties)
                    print(Utility.Instance.propertyListViewModel.propertyAt(0))
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
        return Utility.Instance.propertyListViewModel == nil ? 0: Utility.Instance.propertyListViewModel.propertyViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath) as? PropertyCell else {
            fatalError("PropertyCell not found")
        }
        
        cell.indexPath = indexPath.row
        
        var utility = Utility.Instance.checkedCells
//        if utility.contains(indexPath.row){
//            Utility.Instance.propertyListViewModel.setPropertyVmFavAt(indexPath.row, bool: true)
////            var vm = Utility.Instance.propertyListViewModel.propertyAt(indexPath.row)
////            vm.isFavourite = true
////
////            print(vm.address)
////            print(vm.id)
////            print(vm.isFavourite)
//
//        }
    
        var propertyViewModel = Utility.Instance.propertyListViewModel.propertyAt(indexPath.row)
        
        propertyViewModel.isOn.subscribe(onNext: { value in
            print(value)
            if utility.contains(indexPath.row){
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
