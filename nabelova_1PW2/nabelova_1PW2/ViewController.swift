//
//  ViewController.swift
//  nabelova_1PW2
//
//  Created by Наталья Белова on 23.09.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private let settingsView = UIStackView()
    private let locationTextView = UITextView()
    private let locationManager = CLLocationManager()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupSettingsButton()
        setupLocationTextView()
        setupSettingsView()
        setupToggle()
        setupSliders()
        locationManager.requestWhenInUseAuthorization()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func setupLocationTextView(){
        
        view.addSubview(locationTextView)
        locationTextView.backgroundColor = .white
        locationTextView.layer.cornerRadius = 20
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        locationTextView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 60
        ).isActive = true
        locationTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        locationTextView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor,
        constant: 15
        ).isActive = true
        locationTextView.isUserInteractionEnabled = false
        }
        
        
    
    private func setupSettingsView(){
        view.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.backgroundColor = .systemGray4
        settingsView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 60
        ).isActive = true
        settingsView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -15 ).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 300).isActive
            = true
        settingsView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        settingsView.alpha = 0
    }
    private func setupSettingsButton() {
        
        let settingsButton = UIButton(type: .system)
        view.addSubview(settingsButton)
        settingsButton.setImage(
            UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal),
            for: .normal
        )        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 15
        ).isActive = true
        settingsButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -15
        ).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 30).isActive
            = true
        settingsButton.widthAnchor.constraint(equalTo:
                                                settingsButton.heightAnchor).isActive = true
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed),
        for: .touchUpInside)
    }
    let locationToggle = UISwitch()
    private func setupLocationToggle(){
        
        settingsView.addSubview(locationToggle)
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant: 50
        ).isActive = true
        locationToggle.trailingAnchor.constraint(
            equalTo: settingsView.trailingAnchor,
            constant: -10 ).isActive = true
        locationToggle.addTarget(
            self,
            action: #selector(locationToggleSwitched),
            for: .valueChanged
        )
        let locationLabel = UILabel()
        settingsView.addSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant: 55
        ).isActive = true
        locationLabel.leadingAnchor.constraint(
            equalTo: settingsView.leadingAnchor,
            constant: 10
        ).isActive = true
        locationLabel.trailingAnchor.constraint(
            equalTo: locationToggle.leadingAnchor,
            constant: -10
        ).isActive = true
        
    }
    private var buttonCount = 0
    @objc private func settingsButtonPressed(){
        
        let sv = SettingsViewController()
        sv.mainViewController = self
        switch buttonCount{
        case 0, 1:
            UIView.animate(withDuration:0.1, animations: {
                self.settingsView.alpha = 1 - self.settingsView.alpha
            })
        case 2:
            
            navigationController?.pushViewController(                
                sv, animated:true
            )
        case 3:
            present(sv, animated: true,completion: nil)
        default:
            buttonCount = -1}
        
        buttonCount+=1
        
        
    }

    @objc
    func locationToggleSwitched(_ sender: UISwitch) {
    if sender.isOn {
        if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            locationToggle.isOn = true
        } else {
            sender.setOn(false, animated: true)
            locationToggle.isOn = false
        }
    } else {
    locationTextView.text = ""
    locationManager.stopUpdatingLocation()
    }
    }
    public let sliders = [UISlider(), UISlider(), UISlider()]
    public let colors = ["Red", "Green", "Blue"]
    private func setupSliders() {
        var top = 80
        for i in 0..<sliders.count {
            let view = UIView()
            settingsView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(
                equalTo: settingsView.leadingAnchor,
                constant: 10
            ).isActive = true
            view.trailingAnchor.constraint(
                equalTo: settingsView.trailingAnchor,
                constant: -10 ).isActive = true
            view.topAnchor.constraint(
                equalTo: settingsView.topAnchor,
                constant: CGFloat(top)
            ).isActive = true
            view.heightAnchor.constraint(equalToConstant: 30).isActive =
                true
            top += 40
            let label = UILabel()
            view.addSubview(label)
            label.text = colors[i]
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 5
            ).isActive = true
            label.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ).isActive = true
            label.widthAnchor.constraint(
                equalToConstant: 50
            ).isActive = true
            let slider = sliders[i]
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.addTarget(self, action:
            #selector(sliderChangedValue), for: .valueChanged)
            view.addSubview(slider)
            slider.topAnchor.constraint(equalTo: view.topAnchor,
            constant: 5).isActive = true
            slider.heightAnchor.constraint(equalToConstant: 20).isActive
            = true
            slider.leadingAnchor.constraint(equalTo:
            label.trailingAnchor, constant: 10).isActive = true
            slider.trailingAnchor.constraint(equalTo:
            view.trailingAnchor).isActive = true
        }
    }
    
    @objc func sliderChangedValue() {
    let red: CGFloat = CGFloat(sliders[0].value)
    let green: CGFloat = CGFloat(sliders[1].value)
    let blue: CGFloat = CGFloat(sliders[2].value)
    view.backgroundColor = UIColor(red: red, green: green, blue:
    blue, alpha: 1)
    }
    private func setupCloseButton() {
        let button = UIButton(type: .close)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -10
        ).isActive = true
        button.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive =
            true
        button.widthAnchor.constraint(equalTo:
                                        button.heightAnchor).isActive = true
        button.addTarget(self, action: #selector(closeScreen),
                         for: .touchUpInside)
     }
    @objc
    private func closeScreen(){
        dismiss(animated: true, completion: nil)
    }
    private func setupToggle(){
        let locationToggle = UISwitch()
        settingsView.addSubview(locationToggle)
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant: 50
        ).isActive = true
        locationToggle.trailingAnchor.constraint(
            equalTo: settingsView.trailingAnchor,
            constant: -10 ).isActive = true
        locationToggle.addTarget(
            self,
            action: #selector(locationToggleSwitched),
            for: .valueChanged
        )
        let locationLabel = UILabel()
        settingsView.addSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant: 55
        ).isActive = true
        locationLabel.leadingAnchor.constraint(
            equalTo: settingsView.leadingAnchor,
            constant: 10
        ).isActive = true
        locationLabel.trailingAnchor.constraint(
            equalTo: locationToggle.leadingAnchor,
            constant: -10
        ).isActive = true
        
    }
   

}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D =
manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}


