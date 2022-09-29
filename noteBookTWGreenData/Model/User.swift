//
//  User.swift
//  noteBookTWGreenData
//
//  Created by Vadim Igdisanov on 28.09.2022.
//

import Foundation

class User {
    let name: String
    let gender: String
    let email: String
    let urlPhoto: String
    let dob: String
    let age: Int64
    let timeZone: String
    let gMT: String
    
    init(name: String, gender: String, email: String, urlPhoto: String, dob: String, age: Int64, timeZone: String, gmt: String) {
        self.gMT = gmt
        self.age = age
        self.dob = dob
        self.email = email
        self.gender = gender
        self.timeZone = timeZone
        self.urlPhoto = urlPhoto
        self.name = name
        
    }
    
    init?(results: Results) {
        guard let title = results.name?.title,
              let first = results.name?.first,
              let last = results.name?.last,
              let email = results.email,
              let gender = results.gender,
              let date = results.dob?.date,
              let age = results.dob?.age,
              let urlPhoto = results.picture?.medium,
              let timeZone = results.location?.timezone?.description,
              let gMT = results.location?.timezone?.offset
                
        else {
            return nil
        }
        
        self.name = "\(title) \(first) \(last)"
        self.gender = gender
        self.email = email
        self.dob = date
        self.age = Int64(age)
        self.urlPhoto = urlPhoto
        self.timeZone = timeZone
        self.gMT = gMT
    }
}
