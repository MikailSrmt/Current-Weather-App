//
//  ViewController.swift
//  Current Weather App
//
//  Created by Ruslan Ismayilov on 2/24/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var hamburgerView: UIView!
    
    @IBOutlet weak var hamburgerViewLeadingC: NSLayoutConstraint!
    @IBOutlet weak var hamburgerViewTrailingC: NSLayoutConstraint!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    var networkWeatherClient = NetworkWeatherClient()
    var menuOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hamburgerView.isHidden = true
        
        
                    self.networkWeatherClient.onCompletion = {[weak self]currentWeather in
                        print(currentWeather.cityName)
                        guard let self = self else {return}
                        self.updateInterfaceWith(weather: currentWeather)
                        
                       
                    }
        
        networkWeatherClient.fetchCurrentWeather(forCity: "San Francisco")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hamburgerView.isHidden = true
        
        
        networkWeatherClient.fetchCurrentWeather(forCity: "San Francisco")
        
    }

    @IBAction func menuButtonClicked(_ sender: Any) {
        hamburgerView.isHidden = false
        if menuOut == false{
//            hamburgerViewLeadingC.constant = 0
//            hamburgerViewTrailingC.constant = 0
            menuOut = true
        } else {
//            hamburgerViewLeadingC.constant = 0
//            hamburgerViewTrailingC.constant = 0
            menuOut = false
            hamburgerView.isHidden = true
        }
//
//        UIView.animate(withDuration: 3, delay: 0.0, options: .curveEaseIn, animations:  {
//            self.view.setNeedsLayout()
//            self.view.layoutIfNeeded()
//        })

//                        {(animationComplete) in
//                            print("The animation is complete")
//
//        }


    }
    @IBAction func seacrhButtonTapped(_ sender: Any) {
        self.presentSearchAlertController(title: "Enter city name", message: nil, style: .alert){ [unowned self] city in
            self.networkWeatherClient.fetchCurrentWeather(forCity: city)
            
        }
    
    }
    
    func updateInterfaceWith(weather : CurrentWeather){
        DispatchQueue.main.async {
            
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
            
        }
        
    }
    


                   
    }
    
