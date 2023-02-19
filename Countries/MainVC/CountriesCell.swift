//
//  CountriesCell.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import UIKit

class CountriesCell: UITableViewCell {

    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCountryDetail: UILabel!
    @IBOutlet weak var lblCapital: UILabel!
    @IBOutlet weak var imgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgFlag.layer.masksToBounds = true
        imgFlag.layer.borderWidth = 0.5
        imgFlag.layer.borderColor = UIColor.gray.cgColor   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
