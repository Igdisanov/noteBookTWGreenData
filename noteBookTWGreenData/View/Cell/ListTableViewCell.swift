//
//  ListTableViewCell.swift
//  noteBookTWGreenData
//
//  Created by Vadim Igdisanov on 26.09.2022.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = userImageView.frame.width/2
    }
    
    func configure(user: User) {
        self.userNameLable.text = user.name
        
        guard let url = URL(string: user.urlPhoto) else {return}
        getImage(url: url)
    }
    
    private func getImage(url: URL) {
        NetworkService.shared.getImage(url: url) { (image) in
            self.userImageView.image = image
        }
    }
    
}
