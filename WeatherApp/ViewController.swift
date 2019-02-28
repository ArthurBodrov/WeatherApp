//
//  ViewController.swift
//  WeatherApp
//
//  Created by Arthur on 11.02.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }


}


extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let urlString = "https://api.apixu.com/v1/current.json?key=2fcbca7114dd43fb82e144949180601&q=\(searchBar.text!)"
        
        let url = URL.init(string: urlString)
        
        var locationName: String?
        var temperature: Double?
        
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error ) in
            do {
            
            let json =
                try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                }
                
                if let current = json["current"] {
                    temperature = current["temp_c"] as? Double
                }
                
                DispatchQueue.main.async {
                    self.cityLabel.text = locationName
                    
                    self.temperatureLabel.text  = "\(Int(temperature!))˚C"
                }
                
                
                
                
            }
            catch let jsonError {
                print(jsonError)
            }
            
    }
        task.resume()
}
}
