//
//  MapViewController.swift
//  FinalProject
//
//  Created by Бекзат Ратбек on 13.12.2024.
//

import UIKit
import CoreLocationUI
import CoreLocation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class MapViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
        
    }()
    
    private let searchBar: UISearchBar = {
          let searchBar = UISearchBar()
          return searchBar
      }()

    private var bookMagazineAnnotation: LocationAnnotation?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        
        view.addSubview(searchBar)
        
        LocationManager.shared.getUserLocation{ [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addPin(with: location)
            }
        }
       
    }
    
    override func viewDidLayoutSubviews() {
        map.frame = CGRect(x: 0, y: 130, width: view.bounds.width, height: view.bounds.height - 50)
        searchBar.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 50)
    }
    
    
    func addPin(with location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocation(with: location, completion: { [weak self] locationName in
            self?.title = locationName
            
        })
        configureSearchBar()
    }
    
    func configureSearchBar() {
           searchBar.delegate = self
       }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.lowercased() == "book magazines" {
                    addBookMagazineAnnotation()
                } else {
                    removeBookMagazineAnnotation()
                }
     }

     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.resignFirstResponder()
     }
    
    func addBookMagazineAnnotation() {
        guard bookMagazineAnnotation == nil else { return }

        let location = CLLocation(latitude: 43.2551, longitude: 76.9126)
        bookMagazineAnnotation = LocationAnnotation(coordinate: location.coordinate, title: "Book Magazine", subtitle: "Your favorite book magazine location")
        map.addAnnotation(bookMagazineAnnotation!)
    }

    func removeBookMagazineAnnotation() {
        guard let bookMagazineAnnotation = bookMagazineAnnotation else { return }
        map.removeAnnotation(bookMagazineAnnotation)
        self.bookMagazineAnnotation = nil
    }
   
    
}

