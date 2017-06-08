//
//  CurrentWeather.swift
//  CassandraTest
//
//  Created by Raddaoui Mohamed Raid on 6/2/17.
//  Copyright © 2017 tn.esprit.CassandraTest. All rights reserved.
//

import UIKit
import Alamofire
class CurrentWeather {
    var _cityName:String!
    var _date:String!
    var _weatherType:String!
    var _currentTemp :Double!

    var cityName:String{
        if (_cityName == nil){
        
        _cityName = "-----"}
        return _cityName
    }
    
    var date:String{
        if (_date == nil){
            
            _date = ""}
        
        
    let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    
    

    var weatherType:String{
        if (_weatherType == nil){
            
            _weatherType = "-----"}
        return _weatherType
    }
    
    var currentTemp:Double{
        if (_currentTemp == nil){
            
            _currentTemp = 0.0}
        return _currentTemp
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
 //AlamoFire download
    
       // let CurrentURL = URL(string: CURRENT_URL)!
        Alamofire.request(CURRENT_URL).responseJSON{ response in
        let results = response.result
        //    print("leeee 3ad")
          //  print(response)
            
            if let dict = results.value as? Dictionary<String,AnyObject>{
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                 //   print(self._cityName)

                }
                ///////////////////
                if let  weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                    self._weatherType = main.capitalized
                   //     print(self._weatherType)

                    }
                }
                ///////////////////
                if let  main = dict["main"] as? Dictionary<String,AnyObject> {
                    if let temperature = main["temp"] as? Double! {

                        
                        
                        
                       // print("miiiiijouuuuuuuud")
                        
                        //print(temperature)
                        let celsiusTemp = temperature - 273.15
                        self._currentTemp = celsiusTemp
                  //  print(self._currentTemp)

                    }
                }
                
            
            }
        
        completed()
        }
    
    
    
    
    
    
    
    }









}
