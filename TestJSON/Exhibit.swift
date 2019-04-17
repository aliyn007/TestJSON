//
//  Exhibit.swift
//  TestJSON
//
//  Created by Александр on 4/15/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class Exhibit : Decodable {
    let list : [Product]
}
class Product : Decodable {
    let title : String
    let images : [URL]
}


extension URL {
    func downloadImg(completion: @escaping (UIImage?)->()) {
        
        let task = URLSession.shared.dataTask(with: self) { (data,response,error) in
            
            
            guard let data = data else { return }
            guard error == nil else {return}
            
       
                if let image = UIImage(data: data) {
                    completion(image)
               
            } else {
                    print("\(String(describing: error))")
                
            }
        }
        task.resume()
    }
}
