//
//  CityWeatherData.swift
//  Weather
//
//  Created by ZL on 2021/5/28.
//  Copyright © 2021 ZL. All rights reserved.
//

import UIKit

class CityWeatherData: NSObject {
    var id: String!  //当前城市的id
    var name: String!
    var daily = Array<Daily_Forecast>()  //七天预报
    var update: String! //数据更新时间
    
    init(json: JSON){
        daily.removeAll()
        
        let i = json
        print(i)
        id = i["cityid"].string!
        // id = s.substring(from: s.index(s.startIndex, offsetBy: 2))  // swift 2.0
        // id = String(s[s.index(s.startIndex, offsetBy: 1)...])   // swift 3.0
        update = i["update_time"].string!
        // update = s.substring(from: s.index(s.startIndex, offsetBy: 11))
        // update = String(s[s.index(s.startIndex, offsetBy: 3)...])
        name = i["city"].string!
        for j in i["data"]{
            daily.append(Daily_Forecast(json: j.1))
        }
    }
}

class Daily_Forecast: NSObject{
    var date: String!
    var wea: String!
    var wea_img: String!
    var tem_day: String!
    var tem_night: String!
    var win: String!
    var win_speed: String!
    
    init(json: JSON){
        date = json["date"].string!
        wea = json["wea"].string!
        wea_img = json["wea_img"].string!
        tem_day = json["tem_day"].string!
        tem_night = json["tem_night"].string!
        win = json["win"].string!
        win_speed = json["win_speed"].string!
    }
}
