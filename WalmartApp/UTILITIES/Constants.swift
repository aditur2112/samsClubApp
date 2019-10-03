//
//  NetworkConstants.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import Foundation
import CoreGraphics

struct APIConstants{
    static let URL_PREFIX = "https://mobile-tha-server.firebaseapp.com"
    static let LIST_ENDPOINT = "/walmartproducts"
    static let IMAGE_ENDPOINT = "/images/%@"
    static let APPLN_JSON = "application/json"
    static let REACHABILITY_CHANGED_NOTIFICATION =  "Notification.Name.ReachabilityChangedNotification"
}

struct ParamConstants{
    static let page_num = "pageNum"
    static let page_size = "pageSize"
}

struct ErrorConstants{
    static let serverError = 404
}

struct CellHeights{
    static let normalHeight : CGFloat = 100.0
    static let semiHeaderHeight : CGFloat = 160.0
    static let headerHeight : CGFloat = 260.0
}
