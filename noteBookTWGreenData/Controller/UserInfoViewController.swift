//
//  UserInfoViewController.swift
//  noteBookTWGreenData
//
//  Created by Vadim Igdisanov on 26.09.2022.
//

import Foundation
import UIKit
import SimpleImageViewer
import FontAwesome_swift

class UserInfoViewController: UIViewController {
    
    var user: User!
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateBirthLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupUserInfo()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        openImageFullScreen(image: userImageView)
    }
    
    private func setupUI() {
        userImageView.layer.cornerRadius = userImageView.frame.width/2
    }
    
    
    private func setupUserInfo() {
        
        self.userNameLabel.text = user.name
        
        self.emailLabel.text = "email: \(user.email)"
        
        setupImageGender(gender: user.gender)
        
        setupDob()
        setupTime()
        guard let url = URL(string: user.urlPhoto) else {return}
        getImage(url: url)
    }
    
    private func getImage(url: URL) {
        NetworkService.shared.getImage(url: url) { (image) in
            self.userImageView.image = image
        }
    }
    
    private func setupImageGender(gender: String){
        if gender == "female" {
            genderImageView.image = UIImage.fontAwesomeIcon(
                name: .venus,
                style: .solid,
                textColor: .label,
                size: CGSize(width: 50, height: 50),
                backgroundColor: UIColor(white: 1, alpha: 0),
                borderWidth: 50,
                borderColor: UIColor(white: 1, alpha: 0))
        } else {
            genderImageView.image = UIImage.fontAwesomeIcon(
                name: .mars,
                style: .solid,
                textColor: .label,
                size: CGSize(width: 50, height: 50),
                backgroundColor: UIColor(white: 1, alpha: 0),
                borderWidth: 50,
                borderColor: UIColor(white: 1, alpha: 0))
        }
    }
    
    private func openImageFullScreen(image: UIImageView) {
        let configuration = ImageViewerConfiguration { config in
            config.imageView = image
        }
        
        let imageViewerController = ImageViewerController(configuration: configuration)
        
        present(imageViewerController, animated: true)
    }
    
    private func setupDob() {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .medium
           dateFormatter.timeStyle = .none
        guard let dateObj: Date = dateFormatterGet.date(from: user.dob) else {return}
        print(dateObj)
        dateBirthLabel.text = "dob: \(dateFormatter.string(from: dateObj)) (\(user.age))"
    }
    
    private func setupTime() {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: user.timeZone)  //В этом месте не могу понять как отобразить время другого часового пояса, данные которые приходят не подходят для этого метода
        
        formatter.dateFormat = "HH:mm:ss"
        self.watchLabel.text = "\(formatter.string(from: currentDate)) \(user.gMT)"
        
        
       
    }
    
}
