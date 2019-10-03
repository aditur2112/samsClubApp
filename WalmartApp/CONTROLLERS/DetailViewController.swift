//
//  DetailViewController.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 9/30/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var product : Products? = nil
    
    @IBOutlet var productImage : UIImageView?
    @IBOutlet var detailTable: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerCells()
        self.navigationItem.title = "Product Detail"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let image = product?.productImage{
            productImage?.loadImageUsingCacheWithUrl(urlString: image)
        }
        self.detailTable?.reloadData()
    }
}
