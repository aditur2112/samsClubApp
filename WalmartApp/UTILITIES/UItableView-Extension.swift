//
//  UItableView-Extension.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit

extension UITableView{
    func getCell<T>(a:T) -> T {
        let cell : T = self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
        return cell
    }
    
    func registerCell<T>(a:T,bundle:Bundle){
        self.register(UINib(nibName: String(describing: T.self), bundle: bundle), forCellReuseIdentifier: String(describing: T.self))
    }
}
