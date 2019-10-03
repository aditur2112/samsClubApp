//
//  UIImage-Extension.swift
//  WalmartApp
//
//  Created by Rajiv Dutta on 10/2/19.
//  Copyright © 2019 BBVA. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func defaultImageSaveToFile(urlString: String,image: UIImage) -> UIImage {
        do {
            let docDir  = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let imageURL = docDir.appendingPathComponent(urlString)
            if let newImage = UIImage(contentsOfFile: imageURL.path){
                saveImageToDefaultUrl(urlString: urlString, image: image)
                return newImage
            }else {
                saveImageToDefaultUrl(urlString: urlString, image: image)
            }
        }catch{}
        return image
    }
    
    func saveImageToDefaultUrl(urlString: String? = String.emptyString,image: UIImage){
        let imageData = image.pngData()!
        let docDir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let imageURL = docDir?.appendingPathComponent(urlString ?? String.emptyString)
        do {
            if let url = imageURL{
                try imageData.write(to: url)
            }
        } catch {}
    }
    
    func loadImageUsingCacheWithUrl(urlString: String, initialLabel:UILabel?=nil, circular:Bool=false, loadImageFromCached:Bool = true,saveAsDefaultImage: String? = nil, canBeDownloaded: Bool = true, completion: ((_ success: Bool) -> Void)? = nil) {
        if let url = URL(string: APIConstants.URL_PREFIX + urlString) {
            var request:URLRequest = URLRequest(url: url)
            
            if (canBeDownloaded){
                if loadImageFromCached {
                    request.cachePolicy = .returnCacheDataElseLoad
                } else {
                    URLCache.shared.removeCachedResponse(for: request)
                    request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
                }
                self.performDownloadingImageRequest(request: request, initialLabel: initialLabel, circular: circular, saveAsDefaultImage: saveAsDefaultImage, completion: completion)
            } else {
                completion?(false)
            }
        }
    }
    
    func performDownloadingImageRequest(request: URLRequest, initialLabel:UILabel?=nil, circular:Bool=true, saveAsDefaultImage: String? = nil, completion: ((_ success: Bool) -> Void)? = nil){
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                completion?(false)
                return
            }
            DispatchQueue.main.async {
                if let unwrappedData = data, let image = UIImage(data: unwrappedData) {
                    self.image = image
                    initialLabel?.text = ""
                    if let saveAsDefaultImage = saveAsDefaultImage {
                        let image = self.defaultImageSaveToFile(urlString: saveAsDefaultImage, image: image)
                        self.image = image
                    }
                    if circular {
                        self.maskCircle(anyImage: image)
                    }
                    completion?(true)
                }
            }
        }).resume()
    }
    
    func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    func circularImage(image: UIImage){
        maskCircle(anyImage: image)
        self.image = image
    }

}
