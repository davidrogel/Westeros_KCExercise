//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 23/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Episode]
    
    // MARK: - Initialization
    init(model: [Episode])
    {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Episodes"
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
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME)
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange(notification:)), name: name, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func seasonDidChange(notification: Notification)
    {
        guard let userInfo = notification.userInfo, let season = userInfo[SEASON_KEY] as? Season else
        {
            return
        }
        
        model = season.sortedEpisodes
        tableView.reloadData()
    }
}

extension EpisodeListViewController : UITableViewDataSource
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
        
        cell?.textLabel?.text = episode.title
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let episode = model[indexPath.row]
        
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}

extension EpisodeListViewController : UITableViewDelegate
{
    
}
