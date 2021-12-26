//
//  CustomColour.swift
//  TheMarkBook
//
//  Created by Rakesh Bahadur on 23/12/2021.
//

import SwiftUI
import Foundation

class CustomColour: ObservableObject, Codable {
    
    @Published var schemeIndex: Int = 0
    
    var title: Color = Color.white
    var body: Color  = Color.white
    var accent: Color  = Color.white
    var searchBack: Color  = Color.white
    var searchOverlay: Color  = Color.white
    var back1: Color  = Color.white
    var back2: Color  = Color.white
    
    let schemes = ["Light", "Dark", "Team red", "Team blue", "Team green", "Midnight", "Retro candy"]
    
    init(index: Int) {
        self.changeIndex(index: index)
        loadFromFile()
    }
        
    func changeIndex(index: Int) {
        
        schemeIndex = index
                
        switch index {
        
        case 0:
            // light
            title = Color.black
            body = Color(hue: 0.9, saturation: 0.0, brightness: 0.2)
            accent = Color(red: 0.361, green: 0.827, blue: 0.792)
            searchBack = Color(.systemGray5)
            searchOverlay = Color.gray
            back1 = Color.white
            back2 = Color(hue: 0.9, saturation: 0.0, brightness: 0.9)

        case 1:
            // dark
            title = Color.white
            body = Color(.systemGray5)
            accent = Color(red: 0.247, green: 0.565, blue: 0.541)
            searchBack = Color.gray
            searchOverlay = Color(.systemGray5)
            back1 = Color.black
            back2 = Color(hue: 0.9, saturation: 0.0, brightness: 0.1)
            
        case 2:
            // team red
            title = Color(red: 0.6, green: 0.0, blue: 0.0)
            body = Color(red: 0.3, green: 0.0, blue: 0.0)
            accent = Color(red: 0.8, green: 0.2, blue: 0.2)
            searchBack = Color(.systemGray5)
            searchOverlay = Color.gray
            back1 = Color(hue: 0.9, saturation: 0.0, brightness: 0.7)
            back2 = Color(hue: 0.9, saturation: 0.0, brightness: 0.9)
            
        case 3:
            // team blue
            title = Color(red: 0.0, green: 0.0, blue: 0.6)
            body = Color(red: 0.0, green: 0.0, blue: 0.3)
            accent = Color(red: 0.3, green: 0.3, blue: 0.8)
            searchBack = Color(.systemGray5)
            searchOverlay = Color.gray
            back1 = Color(hue: 0.9, saturation: 0.0, brightness: 0.7)
            back2 = Color(hue: 0.9, saturation: 0.0, brightness: 0.9)
            
        case 4:
            // team green
            title = Color(red: 0.0, green: 0.6, blue: 0.0)
            body = Color(red: 0.0, green: 0.3, blue: 0.0)
            accent = Color(red: 0.2, green: 0.8, blue: 0.2)
            searchBack = Color(.systemGray5)
            searchOverlay = Color.gray
            back1 = Color(hue: 0.9, saturation: 0.0, brightness: 0.7)
            back2 = Color(hue: 0.9, saturation: 0.0, brightness: 0.9)
            
        case 5:
            // midnight
            title = Color(red: 0.0, green: 0.5, blue: 1.0)
            body = Color(red: 0.0, green: 0.4, blue: 0.9)
            accent = Color(red: 0.0, green: 0.2, blue: 0.7)
            searchBack = Color.gray
            searchOverlay = Color(.systemGray5)
            back1 = Color.black
            back2 = Color(hue: 0.9, saturation: 0.0, brightness: 0.1)
            
        case 6:
            // retro candy
            title = Color(hue: 0.9, saturation: 0.0, brightness: 0.05)
            body = Color(hue: 0.9, saturation: 0.0, brightness: 0.2)
            accent = Color(hue: 0.786, saturation: 0.38, brightness: 0.98)
            searchBack = Color(.systemGray5)
            searchOverlay = Color.gray
            back1 = Color(red: 1.0, green: 0.898, blue: 0.698)
            back2 = Color(hue: 0.9, saturation: 0.0, brightness: 0.9)
        
        default:
            schemeIndex = 0
            title = Color.black
            body = Color.black
            accent = Color(red: 0.361, green: 0.827, blue: 0.792)
            searchBack = Color(.systemGray5)
            searchOverlay = Color.gray
            back1 = Color.white
            back2 = Color(.systemGray)
            
        }
        
//        saveToFile()
        
    }
            
    static let initial = CustomColour(index: 0)
    
    // local storage
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        schemeIndex = try container.decode(Int.self, forKey: .schemeIndex)

    }
    
    private enum CodingKeys: CodingKey {
        case schemeIndex
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(schemeIndex, forKey: .schemeIndex)

    }
    
    func loadFromFile() {
        // holds save locations on device for app
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // chooses one of the save locations
        let userPath = paths[0]
        // defines path and name of file
        let url = userPath.appendingPathComponent("customColour.json")
        // fetches data from file
        if let data = try? Data(contentsOf: url) {
            // creates decoder
            let decoder = JSONDecoder()
            // decodes data
            if let loaded = try? decoder.decode(CustomColour.self, from: data) {
                // assigns data to properties
                schemeIndex = loaded.schemeIndex
                changeIndex(index: loaded.schemeIndex)
            }
        }
    }
    
    func saveToFile() {
        // creates encoder
        let encoder = JSONEncoder()
        // encodes data
        if let encoded = try? encoder.encode(self) {
            // converts to string
            if let json = String(data: encoded, encoding: .utf8) {
                // holds save locations on device for app
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                // chooses one of the save locations
                let userPath = paths[0]
                // defines path and name of file
                let url = userPath.appendingPathComponent("customColour.json")
                // in case writing fails
                do {
                    // writes JSON to local file
                    try json.write(to: url, atomically: true, encoding: .utf8)
                } catch {
                    //  prints error message if fails
                    print(error.localizedDescription)
                }
            }
        }
    }
    
        
}
