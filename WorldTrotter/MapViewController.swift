//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Sophia Shaw on 9/6/17.
//  Copyright © 2017 Soph Shaw. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    override func loadView() {
        //Create a map view
        mapView = MKMapView()
        
        //Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", " Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        
        let locationControl = UISegmentedControl(items: ["User Location", "Pin"])
        locationControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        locationControl.selectedSegmentIndex = 0
        
        locationControl.addTarget(self, action: #selector(MapViewController.locationTypeChanged(_:)), for: .valueChanged)
        
        locationControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationControl)
        
        let bottomConstraint = locationControl.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8)
        let leadConstraint = locationControl.leadingAnchor.constraint(equalTo: margins.centerXAnchor)
        let trailConstraint = locationControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        bottomConstraint.isActive = true
        leadConstraint.isActive = true
        trailConstraint.isActive = true

        /*
        let currentLocationButton = UIButton()
        currentLocationButton.setTitle("Current Location", for: [])
        currentLocationButton.setTitleColor(UIColor.black, for: [])
        currentLocationButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        currentLocationButton.frame = CGRectMake(5, 550, 140, 40)
        currentLocationButton.addTarget(self, action: Selector(("pressed")), for: .touchUpInside)
        self.view.addSubview(currentLocationButton)
        
        let pinButton = UIButton()
        pinButton.setTitle("Pin", for: [])
        pinButton.setTitleColor(UIColor.black, for: [])
        pinButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        pinButton.frame = CGRectMake(331, 550, 40, 40)
        pinButton.addTarget(self, action: Selector(("pressed")), for: .touchUpInside)
        self.view.addSubview(pinButton)
         */
    }

    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func currentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let location = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    

        
    let coordinate: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 37.77, longitude: -122.42),
        CLLocationCoordinate2D(latitude: 37.61, longitude: 122.49),
        CLLocationCoordinate2D(latitude: 12.46, longitude: 53.82),
    ]
    
    let caption: [String] = [
        "Location Born",
        "Location Raised",
        "Unique Location"
    ]

    
    var pinIndex: Int = 0
    var captionIndex: Int = 0
    
    func showNextPin (){
        pinIndex += 1
        captionIndex += 1
        if pinIndex == coordinate.count && captionIndex == coordinate.count{
            pinIndex = 0
            captionIndex = 0
        }
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate[pinIndex]
        pin.title = caption[captionIndex]
        mapView.addAnnotation(pin)

    }
    /*
    func raisedPin () {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.61, longitude: 122.49)
        annotation.title = "Location Raised"
        mapView.addAnnotation(annotation)
    }
    
    func uniquePin () {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 12.46, longitude: 53.82)
        annotation.title = "Unique Location"
        mapView.addAnnotation(annotation)
    }
     */
    
    func locationTypeChanged (_ locControl: UISegmentedControl){
        switch locControl.selectedSegmentIndex {
        case 0:
            showNextPin()
        //case 1:
           // locationManager.startUpdatingLocation()
           // bornPin()
        default:
            break
        }
    }
    
    func mapTypeChanged (_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print ("MapViewController loaded its view.")
    }
    
}
