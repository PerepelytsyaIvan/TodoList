//
//  Model.swift
//  TodoList
//
//  Created by Dream Store on 07.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import Foundation
import UIKit
public let arrayStatus = ["Urgently", "Not necessary"]
public let arrayElementTask = ["Name:", "Discription:", "Time interval:", "Staus:", "Date complition:"]

//MARK: - Struct Model
struct Model: Codable {
    var name: String?
    var discription: String?
    var timeInterval: String?
    var status: String?
    var date: String?
    var statusTask: Bool? = false
}

//MARK: - DataMeneger
final class DataMeneger {
    var arrayTask = [Model]()
    static let shared = DataMeneger()
    
    func save() {
        let encodedUserDetails = try? JSONEncoder().encode(arrayTask)
        UserDefaults.standard.set(encodedUserDetails, forKey: "urgently")
    }
    
    func loadData () -> [Model] {
        if let decodedDataUrgently = UserDefaults.standard.object(forKey: "urgently") as? Data {
            if let userDetailsUrgently = try? JSONDecoder().decode([Model].self, from: decodedDataUrgently) {
                arrayTask = userDetailsUrgently
                return arrayTask
            }
        }
        return [Model]()
    }
}

