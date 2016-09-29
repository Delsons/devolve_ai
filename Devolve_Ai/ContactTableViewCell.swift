//
//  ContactTableViewCell.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/27/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var itens: UILabel!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var contactImageData: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
