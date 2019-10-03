//
//  ErrorHandler.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/3/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import UIKit

class ErrorHandler{
    
    static var alertTitle : String = String.emptyString
    static var alertMessage : String = String.emptyString
    
  
    static func handleError(vc: UIViewController, data:Data? = nil, error: Error?, response: HTTPURLResponse?){
        if let err = error {
            alertTitle = "Client error"
            alertMessage =  err.localizedDescription
            showAlertMessage(vc: vc, titleStr: alertTitle, messageStr: alertMessage)
            return
        }
        
        guard let _ = data else{
            alertTitle = "Data not found"
            showAlertMessage(vc: vc, titleStr: alertTitle, messageStr: alertMessage)
            return
        }
        
        guard let resp = response, (200...299).contains(resp.statusCode) else{
            alertTitle = "Server Error"
            alertMessage = response?.statusCode.description ?? String.emptyString
            showAlertMessage(vc: vc, titleStr: alertTitle, messageStr: alertMessage)
            return
        }
        
        guard let mime = response?.mimeType, mime == "application/json" else{
            alertTitle = "Wrong mime type"
            if let err = error {
                alertMessage = err.localizedDescription
            }
            showAlertMessage(vc: vc, titleStr: alertTitle, messageStr: alertMessage)
            return
        }
    }
    
    /*
     Static method for alert User of possible data issues and network errors. Displays an alert for 2 seconds with error description.
     */
    static func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert);
        vc.present(alert, animated: true, completion: nil)
        // delay to desired number of seconds (in this case 2 seconds)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
