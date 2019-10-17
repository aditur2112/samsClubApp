//
//  BaseProduct.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on October 01, 2019
//
import Foundation
import SwiftyJSON

class BaseProduct {

	let products: [Products]?
	let totalProducts: Int?
	let pageNumber: Int?
	let pageSize: Int?
	let statusCode: Int?

	init(_ json: JSON) {
		products = json["products"].arrayValue.map { Products($0) }
		totalProducts = json["totalProducts"].intValue
		pageNumber = json["pageNumber"].intValue
		pageSize = json["pageSize"].intValue
		statusCode = json["statusCode"].intValue
	}

}