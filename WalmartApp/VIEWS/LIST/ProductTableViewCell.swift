//
//  ProductTableViewCell.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet var prodIcon : UIImageView?
    @IBOutlet var prodName : UILabel?
    @IBOutlet var prodDescription : UILabel?
    @IBOutlet var prodPrice : UILabel?
    @IBOutlet var prodRating : UILabel?
    @IBOutlet var prodInStock : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateProductData(prod: Products?){
        if let prodData = prod{
            if let name = prodData.productName{
                prodName?.text = name
            }
            if let desc = prodData.shortDescription{
                let descData = Data(desc.utf8)
                if let attributedString = try? NSAttributedString(data: descData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                    prodDescription?.attributedText = attributedString
                }else{
                    prodDescription?.text = "No Description available"
                    prodDescription?.font = UIFont.boldSystemFont(ofSize: 12.0)
                }
            }
            if let price = prodData.price{
                prodPrice?.text = price
                prodPrice?.textColor = UIColor.brown
            }
            if let rating = prodData.reviewRating{
                prodRating?.font = UIFont.boldSystemFont(ofSize: 10.0)
                prodRating?.text = "Rating:" + String.space + rating.description
            }
            guard let stockInfo = prodData.inStock, stockInfo == true else{
                prodInStock?.text = "Out of Stock"
                prodInStock?.textColor = UIColor.red
                return
            }
            prodInStock?.textColor = UIColor.green
            prodInStock?.text = "In Stock"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
