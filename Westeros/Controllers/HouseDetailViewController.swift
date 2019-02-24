//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 04/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House)
    {
        // Primero lo mio
        self.model = model
        
        // Luego el super
        // si le pasamos nil al primer parametro va a buscar un .xib con el mismo nombre que la clase
        // si le pasamos nil al segundo parametro va a buscar dentro de este namespace (en este caso Westeros)
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con el miedo a nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        setupUI()
    }
    
    // MARK: - Sync
    func syncModelWithView()
    {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    // MARK: - UI
    func setupUI()
    {
        // Añadir el boton para navegar hacia la wiki
        // action es la funcion que se va a ejecutar cuando se pulse el boton
        // target es donde va a estar ese metodo que se va a ejecutar
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMemebers))
        // Mostrar el boton o los botones
        //navigationItem.rightBarButtonItem = wikiButton
        navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }
    
    @objc func displayMemebers()
    {
        let membersViewController = MemberListViewController(model: model.sortedMembers)
        
        navigationController?.pushViewController(membersViewController, animated: true)
    }
    
    // El @objc quiere decir que como esta funcion se va a comunicar con cosas de Objetive-C
    // necesitamos decir que lo que hay dentro va a tener sentido para Objetive-C
    @objc func displayWiki()
    {
        // Creamos el controllador
        let wikiViewController = WikiViewController(model: model)
        // Hacemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
}

extension HouseDetailViewController : HouseListViewControllerDelegate
{
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse house: House)
    {
        self.model = house
        self.title = house.name
        self.syncModelWithView()
        //viewController.navigationController?.pushViewController(self, animated: true)
    }
}
