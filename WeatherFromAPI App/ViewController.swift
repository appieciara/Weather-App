//
//  ViewController.swift
//  WeatherFromAPI App
//
//  Created by @rjun lama on 9/29/17.
//  Copyright © 2017 @rjun lama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var base: UILabel!
    @IBOutlet var visible: UILabel!
    @IBOutlet var locationName: UITextField!
    @IBAction func EnterBtn(_ sender: Any)
    {
        if let url = URL(string: "http://samples.openweathermap.org/data/2.5/weather?q=" + locationName.text! + ",uk&appid=79ef3af11898c812e7a158643cf7b39f")
        {
//            print(locationName.text)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                }else{
                
                    do{
                        let jsonresult =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
//                        print(jsonresult)
                        if let basename = (jsonresult as AnyObject)["base"] as? String
                        {
//                            print(basename)
                            DispatchQueue.main.sync {
                                self.base.text = basename
                            }
                        }
                        
                        if let visibility = (jsonresult as AnyObject)["visibility"] as? NSNumber
                        {
                        
                            DispatchQueue.main.sync {
                                self.visible.text = "\(visibility)"
                            }
                        }
                        if let main = (jsonresult as AnyObject)["main"]
                        {
                            if let humidity = (main as AnyObject)["humidity"] as? NSNumber
                            {
                                DispatchQueue.main.sync {
                                    self.humidity.text = "\(humidity)"
                                }
                            }
                            if let temp = (main as AnyObject)["temp"] as? NSNumber
                            {
                                DispatchQueue.main.sync {
                                    self.temperature.text = "\(temp)"
                                }
                            }
                        }
                    }catch{
                        print("Error")
                    }
                }
            }
           task.resume()
        }else{
            visible.text = "Could not find weather for that location."
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

