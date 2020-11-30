//
//  CustomTableViewCell.swift
//  Bourne Digital Test
//
//  Created by Chirag Chaplot on 1/12/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    var movieImageURL:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    

}
