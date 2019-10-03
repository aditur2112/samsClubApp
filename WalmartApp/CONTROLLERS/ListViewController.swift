//
//  ListViewController.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 9/30/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet var productTable : UITableView?
    
    var networkDispatcher:NetworkDispatcher = NetworkDispatcher()
    var detailViewController = DetailViewController()
    var baseProduct: BaseProduct? = nil
    var totalProducts : Int? = 0
    var pageSize : Int? = 30
    var nextPageNumber = 1
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerCells()
        self.fetchWalmartProducts()
        self.navigationItem.title = "Sam's Club"
        let bundle : Bundle = Bundle(for: type(of: self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailViewController.product = nil
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: String.emptyString, style: .plain, target: nil, action: nil)
    }
    
    func fetchWalmartProducts(pageNumber : Int? = 1, pageSize : Int? = 30){
        isLoading = true
        networkDispatcher.fetchItemsList(pageNum: pageNumber ?? 1, pageSize: pageSize ?? 30, completionHandler: { (BaseProduct, error, response) in
            DispatchQueue.main.async {
                self.isLoading = false
                if let baseProd = BaseProduct, let pageNum = baseProd.pageNumber, pageNum > 0, let pageSze = baseProd.pageSize{
                    self.nextPageNumber = pageNum + 1
                    if pageSze < 30{
                        self.pageSize = pageSze
                    }
                }
                if let baseProd = BaseProduct{
                    self.baseProduct = BaseProduct
                    if let totalProds = baseProd.totalProducts{
                        self.totalProducts = totalProds
                    }
                }else if let err = error{
                    ErrorHandler.handleError(vc:self, data: nil, error:err, response: response)
                }
                self.productTable?.reloadData()
            }
        })
    }
}
