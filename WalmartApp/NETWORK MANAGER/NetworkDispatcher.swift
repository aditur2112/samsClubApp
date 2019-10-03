//
//  NetworkDispatcher.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkDispatcher {
    var networkManager:NetworkManager = NetworkManager()
    
    func fetchItemsList(pageNum:Int, pageSize:Int, completionHandler: @escaping (BaseProduct?, Error?, HTTPURLResponse?)->Void){
        let parameters : NSDictionary = [ParamConstants.page_num: pageNum, ParamConstants.page_size: pageSize]
        NetworkManager.shared.request(baseURL: APIConstants.URL_PREFIX, endpoint: APIConstants.LIST_ENDPOINT, method: .GET, parameters:parameters) {(data, error, response) in
            if let error =  error {
                completionHandler(nil, error, response)
            }else if let data = data{
                let model = BaseProduct(JSON(data))
                completionHandler(model, nil, response)
            }
        }
    }
}
