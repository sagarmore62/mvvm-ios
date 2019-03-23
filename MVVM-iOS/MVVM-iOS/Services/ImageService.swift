//
//  ImageService.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation
import UIKit

class ImageService: NSObject {
    
    class func path(name: String) -> String {
        let finalPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        return finalPath + name
    }
    
    class func getImagen(name: String, size : Int, completion: @escaping(UIImage) -> Void) {
        guard let localImage = UIImage(contentsOfFile: self.path(name: name)) else {
            let url = Constants.domainImage + "w" + String(size) + String(name)
            let qos = DispatchQoS(qosClass: .userInitiated, relativePriority: 0)
            DispatchQueue.global(qos: qos.qosClass).async(execute: {
                let imagenData = NSData(contentsOf: NSURL(string: url)! as URL)
                DispatchQueue.main.async( execute: {
                    imagenData?.write(toFile: self.path(name: name), atomically: true)
                    if let imgData = imagenData{
                        let finalImage = UIImage(data: imgData as Data)
                        completion(finalImage!)
                    }
                })
            })
            return
        }
        completion(localImage)
    }
}
