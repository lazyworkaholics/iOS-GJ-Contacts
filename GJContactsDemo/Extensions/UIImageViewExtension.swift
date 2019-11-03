//
//  UIImageExtension.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

extension UIImageView {
    static var urlCacheImages:NSCache<AnyObject, AnyObject>?
    
    func clearImageCacher() {
        
        UIImageView.urlCacheImages?.removeAllObjects()
    }
    
    func deleteCachedImage(urlString:String) {
        
        if((UIImageView.urlCacheImages?.object(forKey: urlString as AnyObject)) != nil) {
            UIImageView.urlCacheImages?.removeObject(forKey: urlString as AnyObject)
        }
    }
    
    func image(urlString:String, withPlaceHolder placeHolderImage:UIImage?, doOverwrite:Bool) {
        
        if(UIImageView.urlCacheImages == nil) {
            UIImageView.urlCacheImages = NSCache()
        }
        
        if(doOverwrite || ((UIImageView.urlCacheImages?.object(forKey: urlString as AnyObject)) == nil)) {
            
            if placeHolderImage != nil {
                self.image = placeHolderImage
                self.contentMode = .scaleAspectFit
            }
            
            NetworkManager.sharedInstance.httpRequest(urlString, params: nil, method: .GET, headers: nil, body: nil,
                                                      onSuccess: { (data) in
                                                        
                                                        DispatchQueue.main.async(execute: {() -> Void in
                                                            self.image = UIImage.init(data: data)
                                                            self.contentMode = .scaleAspectFit
                                                            UIImageView.urlCacheImages?.setObject(data as AnyObject, forKey: urlString as AnyObject)
                                                        })
            },
                                                      onFailure: { (error) in
                                                        print(error.localizedDescription)
            });
        }
        else {
            
            self.image = UIImage.init(data: UIImageView.urlCacheImages?.object(forKey: urlString as AnyObject) as! Data)
        }
    }
}
