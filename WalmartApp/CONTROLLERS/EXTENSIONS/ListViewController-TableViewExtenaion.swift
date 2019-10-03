//
//  ListViewController-TableViewExtenaion.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit
import Foundation

extension ListViewController: UITableViewDataSource{
    
    func registerCells(){
        self.productTable?.registerCell(a: ProductTableViewCell(), bundle: Bundle(for: ProductTableViewCell.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numOfProducts = baseProduct?.products?.count, numOfProducts > pageSize ?? 1 else{
            return pageSize ?? 1
        }
        return numOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell : ProductTableViewCell? = tableView.getCell(a: ProductTableViewCell())
        if let pageSze = baseProduct?.products?.count, pageSze > indexPath.row ,let productData = baseProduct?.products?[indexPath.row]{
            productCell?.populateProductData(prod: productData)
            if let image = productData.productImage{
                productCell?.prodIcon?.loadImageUsingCacheWithUrl(urlString: image)
            }
        }
        return productCell ?? ProductTableViewCell()
    }
}

extension ListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = pageSize, count > 1{
            let lastElement = count - 1
            if indexPath.row == lastElement && !isLoading{
                //call get api for next page
                self.fetchWalmartProducts(pageNumber: self.nextPageNumber, pageSize: self.pageSize)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let product = baseProduct?.products?[indexPath.row]{
            self.detailViewController.product = product
            self.navigationController?.pushViewController(self.detailViewController, animated: true)
        }
    }
}
