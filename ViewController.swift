//
//  ViewController.swift
//  CassandraTest
//
//  Created by Raddaoui Mohamed Raid on 5/30/17.
//  Copyright © 2017 tn.esprit.CassandraTest. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate   {
    //////blue view
    @IBOutlet var datelabel: UILabel!
    @IBOutlet var currentTemplabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var currentWeatherimg: UIImageView!
    @IBOutlet var currentWeatherLabel: UILabel!
    @IBOutlet var tableview: UITableView!

    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    //class appel
    var details : CurrentWeather!
    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    
    func updateMyUI () {
        datelabel.text  = details.date
        currentTemplabel.text = "\(details.currentTemp)"
        locationLabel.text  = details.cityName
        currentWeatherLabel.text  = details.weatherType
        currentWeatherimg.image = UIImage(named: details.weatherType)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
        currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print("location static")
print(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude)
            
            
            print("location dynamic")
            print(Location.sharedInstance.latitude,Location.sharedInstance.longitude)
            details.downloadWeatherDetails {
                
                self.downloadForeCast {
                    self.updateMyUI()

                }

                
                
            }
            
        }
        
        else {
        locationManager.requestWhenInUseAuthorization()
        locationAuthStatus()
        }
    
    
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        //lcoation
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        details = CurrentWeather()

        
       

        

    
    }

    func downloadForeCast(completed:  @escaping DownloadComplete){
        // download data forecast for the tableview
     //   let forecast_url = URL(string: FORECAST_URL)
        Alamofire.request(FORECAST_URL).responseJSON{ response in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String,AnyObject>
            {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]{
                    
                    for obj in list
                    {
                        
                        let forecast = Forecast (WeatherDict: obj)
                        self.forecasts.append(forecast)
                       print("tfoooooooouuuuuuuuuuuuu")
                        print(self.forecasts.count)
                     
                        
                    }

                    print("-----------------------")
                    print(self.forecasts[1]._highTemp)
                }
                
            }
            
            completed()
            
            self.tableview.reloadData()

            
            
        }

    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return forecasts.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"myCell")!
        

          let imgProfile:UIImageView = cell.viewWithTag(11) as! UIImageView

        let day:UILabel = cell.viewWithTag(12) as! UILabel
        let state:UILabel = cell.viewWithTag(13) as! UILabel
        let max:UILabel = cell.viewWithTag(14) as! UILabel
        let min:UILabel = cell.viewWithTag(15) as! UILabel

//        let alert = UIAlertView()
//        alert.title = "Alert"
//        alert.message = "---"
//        alert.addButton(withTitle: "Ok")
//        alert.show()
//        
        
       // print("\(forecasts[indexPath.row])")
        let forecastings = self.forecasts[indexPath.row]
//        print("blalalalalla")
        print(forecastings)
        day.text = forecastings._date
        state.text = forecastings._weatherType

        max.text = forecastings._highTemp
        min .text = forecastings._lowTemp
        imgProfile.image = UIImage(named: forecastings._weatherType)
        
      //  let lblNom:UILabel = cell.viewWithTag(101) as! UILabel
        
        //  zidha = lblNom.text!
        
      //  let lblDate:UILabel = cell.viewWithTag(102) as! UILabel
      //  lblDate.text = "14/04/2017"
        
      //  let imgProfile:UIImageView = cell.viewWithTag(103) as! UIImageView
        
   
 
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
      
            
        }
       
        
      
        
        
    }
    
    
 
    
    
    
    
 
    
}
