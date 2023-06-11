//
//  Ex+UIViewController.swift
//  DAWAA
//
//  Created by taha hamdi on 6/24/20.
//  Copyright © 2020 taha hamdi. All rights reserved.
//

import UIKit
import MapKit
extension UIViewController {
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    //show side menu from any view controller
    func showNavigationDrawerFromViewController()  {
       
    }
    
    //hide side menu from any view controller
    func hideDrawerControllerFromViewController()  {
        
    }
    
    
    //hide side menue when click on header icon
    func hideDrawerControllerFromSideMenu()   {
       
    }
    
    //show view controller when select from form side menu
    func pushViewControllerFromSideMenu(viewController:UIViewController)  {
        
    }
//       func pushViewControllerFromSideMenu_SWreveal(viewController:UIViewController)  {
//        if let navigationController = (parent as? SWRevealViewController)?.frontViewController as? UINavigationController{
//            if let vc = self.revealViewController()   {
//                if viewController != SideMenuViewController(){
//                    vc.revealToggle(animated: true)
//                }
////                let navController = UINavigationController(rootViewController: viewController)
//                navigationController.pushViewController(viewController, animated: true)
//            }
//        }
//    }
    
//    func presentViewControllerFromSideMenu_SWreveal(viewController:UIViewController)  {
//        if let navigationController = (parent as? SWRevealViewController)?.frontViewController as? UINavigationController{
//            if let vc = self.revealViewController()   {
//                if viewController != SideMenuViewController(){
//                    vc.revealToggle(animated: true)
//                }
//                navigationController.present(viewController, animated: true)
//            }
//        }
//    }
    
    func presentViewControllerFromSideMenu(viewController:UIViewController)  {
//        if let navigationController = (parent as? KYDrawerController)?.mainViewController as? UINavigationController{
//            hideDrawerControllerFromSideMenu()
//            navigationController.present(viewController, animated: true)
//        }
    }
}
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}


extension UserDefaults {
    func decode<T : Codable>(for type : T.Type, using key : String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }

    func encode<T : Codable>(for type : T, using key : String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
    }
}

extension UIViewController {

    func presentDetail(_ viewControllerToPresent: UIViewController, transitionSubtype: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = transitionSubtype
        self.view.window!.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false)
    }

    func dismissDetail(transitionSubtype: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = transitionSubtype
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
}

enum Vibration {
        case error
        case success
        case warning
        case light
        case medium
        case heavy
        @available(iOS 13.0, *)
        case soft
        @available(iOS 13.0, *)
        case rigid
        case selection

        public func vibrate() {
            switch self {
            case .error:
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            case .success:
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            case .warning:
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            case .light:
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            case .medium:
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            case .heavy:
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            case .soft:
                if #available(iOS 13.0, *) {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                }
            case .rigid:
                if #available(iOS 13.0, *) {
                    UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                }
            case .selection:
                UISelectionFeedbackGenerator().selectionChanged()
            }
        }
    }


enum NavigationApps: String {
    case appleMaps = "Maps"
    case googleMaps = "Google Maps"
    case hereWeGo = "HERE WeGo"
}


extension UIViewController {

    // MARK: - Map Navigation

    func openMapForLocation(location: CLLocationCoordinate2D, title: String) {

        let installedNavigationApps : [[String:String]] = [[NavigationApps.appleMaps.rawValue:""], [NavigationApps.googleMaps.rawValue:"comgooglemaps://"], [NavigationApps.hereWeGo.rawValue:"here-route://"]]

        var alertAction: UIAlertAction?

        let alert = UIAlertController(title: "Select Navigation App", message: "\(title) Open in", preferredStyle: .actionSheet)

        for app in installedNavigationApps {
            let appName = app.keys.first
            if (appName == NavigationApps.appleMaps.rawValue ||
                appName == NavigationApps.googleMaps.rawValue || UIApplication.shared.canOpenURL(URL(string:app[appName!]!)!))
            {

                alertAction = UIAlertAction(title: appName, style: .default, handler: { (action) in
                    switch appName {
                    case NavigationApps.appleMaps.rawValue?:
                        let regionDistance:CLLocationDistance = 10000
                        let coordinates = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                        let options = [
                            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                        ]
                        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                        let mapItem = MKMapItem(placemark: placemark)
                        mapItem.name = title
                        mapItem.openInMaps(launchOptions: options)
                        break

                    case NavigationApps.googleMaps.rawValue?:
                        if UIApplication.shared.canOpenURL(URL(string:app[appName!]!)!) {
                            //open in Google Maps application
                            UIApplication.shared.open(URL(string:
                                "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving")! as URL, options: [:], completionHandler: nil)
                        } else {
                            //open in Browser
                            let string = "https://maps.google.com/?q=@\(location.latitude),\(location.longitude)"
                            UIApplication.shared.open(URL(string: string)!)
                        }
                        break

                    case NavigationApps.hereWeGo.rawValue?:
                        UIApplication.shared.open(URL(string:
                            "here-route://mylocation/\(location.latitude),\(location.longitude)?ref=KIZAD&m=d")! as URL, options: [:], completionHandler: nil)
                        break

                    default:
                        break
                    }
                })
                alert.addAction(alertAction!)
            }
            else
            {
                print("Can't open URL scheme")
            }
        }

        alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(alertAction!)

        self.present(alert, animated: true, completion: nil)
    }
}
