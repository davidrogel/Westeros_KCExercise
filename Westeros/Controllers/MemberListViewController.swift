//
//  MemberListViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 20/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initialization
    init(model: [Person])
    {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // tenemos que decirle al tableView cual es su dataSource
        // en este caso nosotros mismos porq heredamos de UITableViewDataSource
        //      en nuestra extension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        
        notificationCenter.addObserver(self, selector: #selector(houseDidChange(notification:)), name: name, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func houseDidChange(notification: Notification)
    {
        guard let info = notification.userInfo, let house = info[HOUSE_KEY] as? House else
        {
            return
        }
        
        model = house.sortedMembers
        tableView.reloadData()
    }
}

extension MemberListViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Descubrir la persona
        let person = model[indexPath.row]
        
        // Pedir una celda a la tabla, si es nil crearla nosotros
        let personId = "PersonCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: personId)
        if(cell == nil)
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: personId)
        }
        
        // Sincronizar model y vista
        cell?.textLabel?.text = person.fullName
        cell?.detailTextLabel?.text = person.alias
        
        // Devolver la celda
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let person = model[indexPath.row]
        
        let memberDetailViewController = MemberDetailViewController(model: person)
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
}

extension MemberListViewController : UITableViewDelegate
{
    
}
