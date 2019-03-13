//
//  HeroBasicInfoTableViewCell.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class HeroBasicInfoTableViewCell: BaseTableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(name: String, description: String){
        nameLabel.text = name
        descriptionLabel.text = description
    }
}
