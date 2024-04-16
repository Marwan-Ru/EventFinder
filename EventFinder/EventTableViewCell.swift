//
//  EventTableViewCell.swift
//  EventFinder
//
//  Created by Marwan Ait Addi on 15/04/2024.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // addShadow()
        
        whiteView.layer.borderWidth = 1
        whiteView.layer.borderColor = UIColor.gray.cgColor
        whiteView.layer.cornerRadius = 10
    }
    
    private func addShadow() {

       whiteView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor

       whiteView.layer.shadowRadius = 2.0

       whiteView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)

       whiteView.layer.shadowOpacity = 2.0
 
    }

    func configure(withIcon icon: String, title: String, subtitle: String) {

       //iconView.image = UIImage(named: icon)

       titleLabel.text = title

       subtitleLabel.text = subtitle

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
