//
//  DetailViewController-Extension.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import Foundation
import UIKit

extension DetailViewController: UITableViewDataSource{
    
    func registerCells(){
        self.detailTable?.registerCell(a: DetailTableViewCell(), bundle: Bundle(for: DetailTableViewCell.self))
        self.detailTable?.registerCell(a: DetailDescTableCell(), bundle: Bundle(for: DetailDescTableCell.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell : DetailTableViewCell? = tableView.getCell(a: DetailTableViewCell())
        let descCell : DetailDescTableCell? = tableView.getCell(a: DetailDescTableCell())
        if let productData = product{
            if indexPath.row == 5{
                descCell?.populateProductData(prod: productData)
                return descCell ?? DetailDescTableCell()
            }else{
                detailCell?.populateProductData(prod: productData, index:indexPath.row)
            }
        }
        return detailCell ?? DetailTableViewCell()
    }
}

extension DetailViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
