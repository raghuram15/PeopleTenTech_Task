//
//  DetailViewController.swift
//  PeopleTenTech_Task
//
//  Created by Raghuram on 29/05/20.
//  Copyright © 2020 Raghuram. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController {

    var model: Restaurents?
    
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager!
    
    
    @IBOutlet weak var restaurentNameLbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var addrlbl: UILabel!
    @IBOutlet weak var phonelbl: UILabel!
    @IBOutlet weak var socialaddrlbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        populateData()
        
       
    }
    
    @IBOutlet weak var mapStackView: UIView!
    @IBAction func mapAction(_ sender: Any) {
        
        mapStackView.isHidden = !mapStackView.isHidden
    }
    
    func populateData(){
        
        guard let model = model else {return}
        
         restaurentNameLbl.text = model.name
         typelbl.text = model.category
        addrlbl.text = "\(model.location?.formattedAddress[0] ?? "")\n\(model.location?.formattedAddress[1] ?? "")"
            
        phonelbl.text = model.contact?.formattedPhone
        socialaddrlbl.text = "@\(model.contact?.twitter ?? "")"
        
        showPinOnMapView(lat: model.location?.lat ?? 0.0, long: model.location?.lng ?? 0.0, country: model.location?.country ?? "")
        
        
    }

    func showPinOnMapView(lat: Double, long: Double,country: String){
        
        let pinlocation = MKPointAnnotation()
        pinlocation.title = country
        pinlocation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.addAnnotation(pinlocation)
        
        
    }
   

}


extension DetailViewController : MKMapViewDelegate, CLLocationManagerDelegate {


   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
      
        return annotationView
    }
    
    
    
}
