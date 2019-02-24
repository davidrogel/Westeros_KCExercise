//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 24/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: - Properties
    var model: Episode
    // MARK: - Initialization
    
    init(model: Episode)
    {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        syncModelAndView()
        title = model.title
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
        
        model = season.sortedEpisodes.first!
        syncModelAndView()
    }
}

extension EpisodeDetailViewController
{
    func syncModelAndView()
    {
        titleLabel.text = model.title
        releaseDateLabel.text = model.releaseDate.description
    }
}
