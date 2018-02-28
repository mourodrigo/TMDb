//
//  UIImageView+Extension.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) -> Void in
            
            if error == nil, let dataImage = data {
                DispatchQueue.main.async {
                    let image = UIImage(data: dataImage)
                    self.image = image
                    
                }
            }
            
        }
        task.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }

}
