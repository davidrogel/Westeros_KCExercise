//
//  AppDelegate.swift
//  Westeros
//
//  Created by david rogel pernas on 31/01/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    var tabBarController: UITabBarController?
    var splitViewController: UISplitViewController?
    
    var houseListViewController: HouseListViewController?
    var seasonListViewController: SeasonListViewController?
    
    var houseDetailViewController: HouseDetailViewController?
    var seasonDetailtViewController: SeasonDetailViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // create new window
        window = UIWindow(frame: UIScreen.main.bounds) /* UIScreen es una clase unica que contiene
                                                            parametros de pantalla */
        // present the window
        window?.makeKeyAndVisible()
        // set color  background
        window?.backgroundColor = .red
        
        // Crearnos los modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Creamos los controladores
//        let controllers = houses
//            .map { HouseDetailViewController(model: $0) }
//            .map { $0.wrappedInNavigation() }
        
        // Crear el combinador y le pasamos los controlladores
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = houses.map { HouseDetailViewController(model: $0).wrappedInNavigation() }
        houseListViewController = HouseListViewController(model: houses)
        seasonListViewController = SeasonListViewController(model: seasons)
        
        // Creamos los controladores (el que irá en Master y el que irá en Details)
//        houseListViewController = HouseListViewController(model: houses)
        let lastSelectedHouse = houseListViewController?.lastSelectedHouse()
//        //let houseDetailViewController = HouseDetailViewController(model: houses.first!)
        houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse!)
        seasonDetailtViewController = SeasonDetailViewController(model: seasons.first!)
//
//
//        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
//        {
//            // Asignar delegado
//            // Un objeto SOLO PUEDE TENER UN DELEGADO
//            // Un objeto PUEDE SER DELEGADO DE MUCHOS OTROS OBJECTOS
//            houseListViewController?.delegate = houseDetailViewController
//        }
//        else
//        {
//
//        }

        houseListViewController?.delegate = houseDetailViewController
        seasonListViewController?.delegate = seasonDetailtViewController
        
        // TAB BAR
        tabBarController = UITabBarController()
        tabBarController?.viewControllers = [houseListViewController!.wrappedInNavigation(), seasonListViewController!.wrappedInNavigation()]
        
        // SPLIT VIEW
        splitViewController = UISplitViewController()
        splitViewController?.viewControllers = [tabBarController!, houseDetailViewController!.wrappedInNavigation()]
        
        tabBarController?.delegate = self
        
        //splitViewController.viewControllers = [houseListViewController.wrappedInNavigation(), houseDetailViewController.wrappedInNavigation()]
        
        // set view controller
        window?.rootViewController = splitViewController
        
        
        return true
    }
}

extension AppDelegate : UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        // esto solo se va a mostrar si estamos en modo apaisado
        if(splitViewController?.isCollapsed == false)
        {
            if tabBarController.selectedIndex == 0
            {
                // lo que vamos a mostrar son los detalles y quien envia el mensaje es el tabBarController
                // cuando clicamos en alguna de sus pestañas
                splitViewController?.showDetailViewController(houseDetailViewController!.wrappedInNavigation(), sender: tabBarController)
            }
            else
            {
                splitViewController?.showDetailViewController(seasonDetailtViewController!.wrappedInNavigation(), sender: tabBarController)
            }
        }
    }
}


