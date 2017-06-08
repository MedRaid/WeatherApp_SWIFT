//
//  Forecast.swift
//  CassandraTest
//
//  Created by Raddaoui Mohamed Raid on 6/4/17.
//  Copyright © 2017 tn.esprit.CassandraTest. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{

    
    var _lowTemp :String!
    var _date:String!
    var _weatherType:String!
    var _highTemp :String!
    
    var weatherType:String{
        if (_weatherType == nil){
            
            _weatherType = "-----"}
        return _weatherType
    }
    
    var date:String{
        if (_date == nil){
            
            _date = ""
        }
        return _date
    }

        var lowTemp:String{
            if (_lowTemp == nil){
                
                _lowTemp = "-----"}
            return _lowTemp
        }
        
        
        var highTemp:String{
            if (_highTemp == nil){
                
                _highTemp = "-----"}
            return _highTemp
        
        }


    init(WeatherDict: Dictionary<String,AnyObject>)
    {
    
        if let temp = WeatherDict["temp"] as? Dictionary<String,AnyObject>
        {
            if let min = temp["min"] as? Double {
                let celsiusTemp = min - 273.15
                self._lowTemp = "\(celsiusTemp)"
            }
            ////////////
            if let max = temp["max"] as? Double {
                let celsiusTemp = max - 273.15
                self._highTemp = "\(celsiusTemp)"
                
            }///////////
        }
    ////////////
        if let weather = WeatherDict["weather"] as? [Dictionary<String,AnyObject>]
        {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                
            }
        
        }
    ////////////
        
        if let date = WeatherDict["dt"] as? Double
        {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayoftheWeek() 
            
            
        }
        
        
    }

}

extension Date{
    func dayoftheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
        return dateFormatter.string(from: self)
    
    }

}
