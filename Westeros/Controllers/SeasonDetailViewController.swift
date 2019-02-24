//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 23/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

// season detail debería tener una lista con los episodios
class SeasonDetailViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    var model: Season
    
    // MARK: - Initialization
    init(model: Season)
    {
        self.model = model
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        title = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        syncModelWithView()
        setupUI()
    }
    
    // MARK: - Sync
    func syncModelWithView()
    {
        nameLabel.text = "\(model.name)"
        dateLabel.text = "\(model.releaseDate.description)"
    }
    
    // MARK: - UI
    func setupUI()
    {
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        navigationItem.rightBarButtonItem = episodesButton
    }
    
    @objc func displayEpisodes()
    {
        let episodesListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        navigationController?.pushViewController(episodesListViewController, animated: true)
    }
}

extension SeasonDetailViewController : SeasonListViewControllerDelegate
{
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season)
    {
        self.model = season
        self.title = season.name
        self.syncModelWithView()
    }
    
    
}
