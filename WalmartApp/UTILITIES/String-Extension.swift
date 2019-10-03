//
//  String-Extension.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit
import Foundation

public extension String {
    
    static var emptyString : String {
        get {
            return ""
        }
    }
    
    static var space : String {
        get {
            return " "
        }
    }
    
    static func stringWithSpaces(count: Int = 1) -> String {
        return String(repeating: " ", count: count)
    }
}
