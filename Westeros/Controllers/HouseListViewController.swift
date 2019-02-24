//
//  HouseListViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 20/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

// Definir nuestro propio delegado
protocol HouseListViewControllerDelegate : class
{
    // Should - Will - Did
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse: House)
}

class HouseListViewController: UITableViewController
{
    // MARK: - Properties
    let model:[House]
    weak var delegate: HouseListViewControllerDelegate?
    
    // MARK: - Inicialization
    init(model:[House])
    {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    // podemos borrar viewDidLoad ya que no vamos a cargar por aqui la informacion
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.count
    }

    
    // va a recorrer cada celda y le va a ir pasando la casa que corresponda segun "indexPath"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Descubrir cual es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        // vamos a tener un ID
        let cellId = "HouseCell"
        // vamos a buscar una Celda con ese ID
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        // si no existe una celda
        if cell == nil
        {
            // la creamos, con lo que al volver arriba ya existirá
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar Celda y Modelo
        cell?.textLabel?.text = house.name
        cell?.imageView?.image = house.sigil.image
        
        // Devolver la celda
        return cell!
    }
    
    // MARK: - UITableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    
    // vamos a hacer que si pulsas una casa vayas a su vista
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // Averiguar la casa que se ha pulsado
        let house = model[indexPath.row]
        
        // Avisamos al delegado
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Emitir la misma info por notificaciones
        // Creamos la notificacion
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        let notification = Notification(
            name: name,
            object: self,
            userInfo: [HOUSE_KEY: house]
        )
        
        // Enviamos una notificacion
        notificationCenter.post(notification)
        
        // Guardar la casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
        
        
        
//        // Crear el controlador de detalle de esa casa
//        let houseDetailViewController = HouseDetailViewController(model: house)
//        // Vamos a mostrarlo (Push)
//        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}

extension HouseListViewController
{
    func saveLastSelectedHouse(at index: Int)
    {
        // UserDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: LAST_HOUSE_KEY)
        // esto es como un save
        userDefaults.synchronize() // esto lo van a deprecar
    }
    
    func lastSelectedHouse() -> House
    {
        // Recuperar la ultima casa que hemos clicado y pasarsela a los detalles en vez de pasar siempre la primera
        let userDefaults = UserDefaults.standard
        let lastHouse = userDefaults.integer(forKey: LAST_HOUSE_KEY)
        return model[lastHouse]
    }
}

