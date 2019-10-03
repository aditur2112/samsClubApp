//
//  DetailDescTableCell.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/2/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit

class DetailDescTableCell: UITableViewCell {

    @IBOutlet var label : UILabel?
    @IBOutlet var title : UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateProductData(prod: Products?){
        title?.text = "Description:"
        if let desc = prod?.longDescription{
            let descData = Data(desc.utf8)
            if let attributedString = try? NSAttributedString(data: descData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label?.attributedText = attributedString
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
