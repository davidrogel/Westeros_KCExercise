//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by david rogel pernas on 24/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    
    // MARK: - Properties
    let model: Person
    
    // MARK: - Initialization
    init(model: Person)
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
    }
    
    func syncModelAndView()
    {
        nameLabel.text = model.name
        aliasLabel.text = model.alias
    }
}
