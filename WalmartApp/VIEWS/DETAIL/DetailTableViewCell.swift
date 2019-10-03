//
//  DetailTableViewCell.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/1/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet var title : UILabel?
    @IBOutlet var label : UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateProductData(prod: Products?, index:Int){
        if let prodData = prod{
            switch index {
                case 0:
                    title?.text = "Product Name:"
                    label?.text = prodData.productName
                    label?.textColor = UIColor.blue
                    label?.font = UIFont.boldSystemFont(ofSize: 16.0)
                case 1:
                    title?.text = "Specification:"
                    if let desc = prod?.shortDescription{
                        let descData = Data(desc.utf8)
                        if let attributedString = try? NSAttributedString(data: descData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                            label?.attributedText = attributedString
                            label?.textColor = UIColor.darkGray
                        }
                    }
                case 2:
                    title?.text = "Price:"
                    label?.text = prodData.price
                    label?.textColor = UIColor.brown
                case 3:
                    title?.text = "Total Reviews:"
                    label?.text = prodData.reviewCount?.description
                case 4:
                    title?.text = "Rating:"
                    label?.text = prodData.reviewRating?.description
                default:
                    break
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
