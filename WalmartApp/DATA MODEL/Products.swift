//
//  Products.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on October 01, 2019
//
import Foundation
import SwiftyJSON

class Products {

	let productId: String?
	let productName: String?
	let shortDescription: String?
	let longDescription: String?
	let price: String?
	let productImage: String?
	let reviewRating: Int?
	let reviewCount: Int?
	let inStock: Bool?

	init(_ json: JSON) {
		productId = json["productId"].stringValue
		productName = json["productName"].stringValue
		shortDescription = json["shortDescription"].stringValue
		longDescription = json["longDescription"].stringValue
		price = json["price"].stringValue
		productImage = json["productImage"].stringValue
		reviewRating = json["reviewRating"].intValue
		reviewCount = json["reviewCount"].intValue
		inStock = json["inStock"].boolValue
	}

}