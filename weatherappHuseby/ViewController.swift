//
//  ViewController.swift
//  weatherappHuseby
//
//  Created by CATHERINE HUSEBY on 1/8/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherlabel: UILabel!
    
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    @IBOutlet weak var HumidityLabel: UILabel!
    
    
    @IBOutlet weak var sunsetTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getweather()
        // Do any additional setup after loading the view.
    }
    
    func getweather(){
        // creating object of URLSession class to make api call
        let session = URLSession.shared

                //creating URL for api call (you need your apikey)
                let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=-88.99&units=imperial&appid=6a76c3b63ebba36b8f19599ab210cb97")!
        
        // Making an api call and creating data in the completion handler
                let dataTask = session.dataTask(with: weatherURL) {
                    // completion handler: happens on a different thread, could take time to get data
                    (data: Data?, response: URLResponse?, error: Error?) in

                    if let error = error {
                        print("Error:\n\(error)")
                    } else {
                        // if there is data
                        if let data = data {
                            // convert data to json Object
                            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                                // print the jsonObj to see structure
                                print(jsonObj)
                                
                                // find main key and get all the values as a dictionary
                                if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary {
                                    
                                    // get the value for the key temp
                                    if let temperature = mainDictionary.value(forKey: "temp") {
                                        // make it happen on the main thread so it happens during viewDidLoad
                                        DispatchQueue.main.async {
                                            // making the value show up on a label
                                            self.weatherlabel.text = "Temperature: \(temperature) degrees fahrenheit"
                                        }
                                        
                                } else {
                                        print("Error: unable to find temperature in dictionary")
                                    }
                                    
                                    if let min = mainDictionary.value(forKey: "temp_min") {
                                        
                                        DispatchQueue.main.async {
                                            self.minTempLabel.text = "Minimum temp: \(min) degrees fahrenheit"
                                            
                                            
                                        }
                                
                                    }
                                    
                                    if let max = mainDictionary.value(forKey: "temp_max") {
                                        DispatchQueue.main.async {
                                            self.maxTempLabel.text = "Max temp: \(max) degrees fahrenheit"
                                            
                                            
                                        }
                                        
                                    }
                                    
                                    if let humidity = mainDictionary.value(forKey: "humidity") {
                                        DispatchQueue.main.async {
                                            self.HumidityLabel.text = "Humidity level: \(humidity)%"
                                            
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    //let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
                                } else {
                                    print("Error: unable to convert json data")
                                }
                                
                                if let mainDictionary = jsonObj.value(forKey: "sys") as? NSDictionary {
                                    
                                    if let sunset = mainDictionary.value(forKey: "sunset") as? Int {
                                        
                                        let yay = Date(timeIntervalSince1970: TimeInterval(sunset)).formatted(.dateTime)
                        
                                        DispatchQueue.main.async {
                    
                                            
                                            self.sunsetTime.text = "Sunset time: \(yay)"
                                            
                                            
                                        }
                                    }

                                    
                                    
                                    
                                }
                                
                            
                            }
            else {
                print("Error: Can't convert data to json object")
                            }
                            
                            
                            
                            
                            
                            
    }
    else {
        print("Error: did not receive data")
        }
                        
            
                        
                        
                        
                    }
                }

                dataTask.resume()

    }


}


