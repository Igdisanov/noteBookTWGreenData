//
//  User.swift
//  noteBookTWGreenData
//
//  Created by Vadim Igdisanov on 26.09.2022.
//

import Foundation

struct GetResultsResponse: Decodable {
    let results: [Results]?
}

struct Results: Decodable {
    
    let email: String?
    let gender: String?
    let location: Location?
    let name: Name?
    let picture: Picture?
    let dob: Dob?

}

struct Location: Decodable {
    let city: String?
    let coordinates: Coordinates?
    let country: String?
    let state: String?
    let street: Street?
    let timezone: Timezone?
}

struct Name: Decodable {
    let first: String?
    let last: String?
    let title: String?
}

struct Picture: Decodable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}

struct Timezone: Decodable {
    let description: String?
    let offset: String?
}

struct Street: Decodable {
    let name: String?
    let number: Int?
}

struct Coordinates: Decodable {
    let latitude: String?
    let longitude: String?
}

struct Dob: Decodable {
    let date: String?
    let age: Int?
}
