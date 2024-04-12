//
//  MapViewController.swift
//  EventFinder
//
//  Created by Leo Bernard on 08/04/2024.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /*if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            //map.setRegion(region, animated: true)
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        
        map.delegate = self
        
        addInitialPin()
    }
    
    private func addInitialPin(){
        for event in events {
            let annotation = MKPointAnnotation()
            annotation.title = event.name
            annotation.subtitle = event.desc
            annotation.coordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            
            map.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            // Ne pas changer l'icône de localisation de l'utilisateur
            return nil
        } else {
            let annotationIdentifier = "CustomPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            // Modifier la couleur du pointeur
            annotationView?.markerTintColor = #colorLiteral(red: 0, green: 0.1121444181, blue: 0.1947939992, alpha: 1)
            
            return annotationView
        }
    }


    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
