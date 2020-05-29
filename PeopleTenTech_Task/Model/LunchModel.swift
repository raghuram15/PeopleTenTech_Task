//
//  LunchModel.swift
//  PeopleTenTech_Task
//
//  Created by Raghuram on 29/05/20.
//  Copyright © 2020 Raghuram. All rights reserved.
//

import Foundation

struct LunchModel: Decodable {
    
    let restaurants : [Restaurents]
    
}

struct Restaurents: Decodable {
    
    let name : String?
    let backgroundImageURL: String?
    let category : String?
    let contact : Contact?
    let location : Location?
}

struct Contact : Decodable {
    let phone : String?
    let formattedPhone : String?
    let twitter : String?
    
}

struct Location : Decodable {
    let address: String?
    let crossStreet: String?
    let lat: Double?
    let lng: Double?
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress : [String]
    
}
