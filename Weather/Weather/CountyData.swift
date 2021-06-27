//
//  CountyData.swift
//  Weather
//
//  Created by ZL on 2021/5/28.
//  Copyright © 2021 ZL. All rights reserved.
//

import UIKit

class CountyData: NSObject {
    
    var id: String!
    var name: String!
    
    init(json: JSON) {
        self.id = json["id"].string!
        self.name = json["name"].string!
    }
    
    init(id: String, name: String) {
        
        self.id = id
        self.name = name

    }
    
    init(json: NSDictionary) {
        
        self.id = "\(json["id"]!)"
        self.name = (json["name"] as! String)
        
    }
    func classToString() -> String{
        
        let str = "{\"id\": \"\(String(describing: self.id!))\", \"name\": \"\(String(describing: self.name!))\"}"
        return str
    }
}

