//
//  SettingsViewController.swift
//  nabelova_1PW2
//
//  Created by Наталья Белова on 23.09.2021.
//

import Foundation
import UIKit
import CoreLocation
public let view = UIStackView()
final class SettingsViewController: UIViewController {
    var mainViewController:ViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsView()
        setupToggle()
        setupSliders()
    }
    private let  settingsView = UIStackView()
    private func setupSettingsView(){
        view.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.pin(to: view)
        settingsView.backgroundColor = .systemGray4
        settingsView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        
        settingsView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -10 ).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 300).isActive =
        true
         settingsView.widthAnchor.constraint(
            equalTo: settingsView.heightAnchor
         ).isActive = true
        
        settingsView.axis = .vertical
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(equalTo:
        settingsView.topAnchor).isActive = true
        settingsView.trailingAnchor.constraint(equalTo:
        settingsView.trailingAnchor).isActive = true
        settingsView.leadingAnchor.constraint(equalTo:
        settingsView.leadingAnchor).isActive = true
    }
    
    private let sliders = [UISlider(), UISlider(), UISlider()]
    private let colors = ["Red", "Green", "Blue"]
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
            sliders[0].value = mainViewController!.sliders[0].value
            sliders[1].value =  mainViewController!.sliders[1].value
            sliders[2].value =  mainViewController!.sliders[2].value
            
        }
    }
    
    @objc private func sliderChangedValue() {
    let red: CGFloat = CGFloat(sliders[0].value)
    let green: CGFloat = CGFloat(sliders[1].value)
    let blue: CGFloat = CGFloat(sliders[2].value)
        mainViewController?.view.backgroundColor = UIColor(red: red, green: green, blue:
    blue, alpha: 1)
        mainViewController!.sliders[0].value = sliders[0].value
        mainViewController!.sliders[1].value = sliders[1].value
        mainViewController!.sliders[2].value = sliders[2].value
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
    let locationToggle = UISwitch()
    private func setupToggle(){
        
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
            action: #selector(toggleSwitched),
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
        if(mainViewController?.locationToggle.isOn == true){
            self.locationToggle.isOn = true
        }
        else{
            self.locationToggle.isOn = false
        }
        
    }
    private let locationTextView = UITextView()
    private let locationManager = CLLocationManager()
    @objc
    func  toggleSwitched(_ sender: UISwitch) {
        mainViewController?.locationToggleSwitched(locationToggle)
        if(self.locationToggle.isOn == true){
            mainViewController?.locationToggle.isOn = true
        }
        else{
            mainViewController?.locationToggle.isOn = false
        }
    }
   
    
}
extension SettingsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D =
manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}
