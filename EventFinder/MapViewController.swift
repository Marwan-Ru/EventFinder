//
//  MapViewController.swift
//  EventFinder
//
//  Created by Leo Bernard on 08/04/2024.
//

import UIKit
import MapKit
import CoreLocation

class CustomPointAnnotation: MKPointAnnotation {
    var type: Int?
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            map.setRegion(region, animated: true)
        }
    }*/
    
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
            let annotation = CustomPointAnnotation()
            annotation.title = event.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            annotation.type = event.type
            annotation.subtitle = event.desc
            map.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let customAnnotation = annotation as? CustomPointAnnotation {
            let annotationIdentifier = "CustomPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKMarkerAnnotationView
           
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
           
            /*  Définir la couleur du pointeur en fonction du type
                type 1 (violet) : Concert
                type 2 (rouge) : Soirée
                type 3 (bleu) : Exposition
                type 4 (orange) : Sport
                type 5 (vert) : Autre
             */
            switch customAnnotation.type {
                //#colorLiteral
                case 1:
                    annotationView?.markerTintColor = #colorLiteral(red: 0.6636011004, green: 0.3285141885, blue: 0.9494089484, alpha: 1)
                case 2:
                    annotationView?.markerTintColor = #colorLiteral(red: 0.8455730081, green: 0, blue: 0, alpha: 1)
                case 3:
                    annotationView?.markerTintColor = #colorLiteral(red: 0.1819998324, green: 0.2313539386, blue: 0.7287663817, alpha: 1)
                case 4:
                    annotationView?.markerTintColor = #colorLiteral(red: 0.934452951, green: 0.3894364238, blue: 0, alpha: 1)
                case 5:
                    annotationView?.markerTintColor = #colorLiteral(red: 0, green: 0.7846129537, blue: 0, alpha: 1)
                default :
                    annotationView?.markerTintColor = #colorLiteral(red: 0, green: 0.7846129537, blue: 0, alpha: 1)
            }
           
            return annotationView
        }
       
        return nil
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
