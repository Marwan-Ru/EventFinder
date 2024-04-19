//
//  MapViewController.swift
//  EventFinder
//
//  Created by Leo Bernard on 08/04/2024.
//

import UIKit
import MapKit
import CoreLocation

/**
 * Modification de la classe MKPointAnnotation pour pouvoir ajouter le type d'event
 */
class CustomPointAnnotation: MKPointAnnotation {
    var type: Int?
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    //Outlet vers notre carte interactive
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialisation du location manager
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        
        map.delegate = self
        
        //appelle de la fonction pour ajouter les marqueurs sur la carte
        addInitialPin()
    }
    
    /**
     * Ajout de tout les marqueurs d'évènements sur la carte
     */
    private func addInitialPin(){
        //parcour de la liste d'évènement
        for event in events {
            //utilisation de notre classe modifié
            let annotation = CustomPointAnnotation()
            //ajout des caractéristiques du marqueur
            annotation.title = event.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
            annotation.type = event.type
            annotation.subtitle = event.desc
            //création du marqueur sur la carte
            map.addAnnotation(annotation)
        }
    }
    
    /**
     * Modification des marqueurs de la carte pour leur donner une couleur par type
     */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //verification que annotation est bien du type CustomPointAnnotation
        if let customAnnotation = annotation as? CustomPointAnnotation {
            let annotationIdentifier = "CustomPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKMarkerAnnotationView
           
            //on vérifie que annotationView existe
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
                //Selon le type on met la couleur correspondante
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
            //retourne l'annotation à afficher sur la carte
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
