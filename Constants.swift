//
//  Constants.swift
//  CassandraTest
//
//  Created by Raddaoui Mohamed Raid on 6/1/17.
//  Copyright © 2017 tn.esprit.CassandraTest. All rights reserved.
//

import Foundation
let BASE_URL = "http://samples.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "b51fb35a9c9d1cd750843ed32cc8c893"
typealias DownloadComplete = () -> ()
//let CURRENT_URL = "\(BASE_URL)\(LATITUDE)-36\(LONGITUDE)123\(APP_ID)\(API_KEY)"
//lat=35&lon=139&appid=b51fb35a9c9d1cd750843ed32cc8c893"






let CURRENT_URL = "http://samples.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=b51fb35a9c9d1cd750843ed32cc8c893"
let FORECAST_URL = "http://samples.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude)&lon=\(Location.sharedInstance.longitude)&cnt=10&appid=b51fb35a9c9d1cd750843ed32cc8c893"
