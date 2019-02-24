//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 23/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate : class
{
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season)
}

// season list va a tener una lista con todas las seasons
class SeasonListViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let model: [Season]
    weak var delegate: SeasonDetailViewController?
    // MARK: - Initialization
    init(model: [Season])
    {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SeasonListViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let episode = model[indexPath.row]
        
        let episodeId = "EpisodeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: episodeId)
        
        if(cell == nil)
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: episodeId)
        }
        
        cell?.textLabel?.text = episode.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let season = model[indexPath.row]
        
        delegate?.seasonListViewController(self, didSelectSeason: season)
     
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME)
        let notification = Notification(name: name, object: self, userInfo: [SEASON_KEY: season])
        
        notificationCenter.post(notification)
        
//        let seasonDetailViewController = SeasonDetailViewController(model: season)
//        navigationController?.pushViewController(seasonDetailViewController, animated: true)
    }
}

extension SeasonListViewController : UITableViewDelegate
{
    
}
