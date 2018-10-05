/* PhotoInfo.swift
   SpacePhoto
   Gets the atronomy picture of the day from NASA website and displays it along with its explanation.
   Created by Nour Yehia on 9/4/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import Foundation

struct PhotoInfo: Codable {
    
    // Declare variables that make up photo item.
    let title: String
    let description: String
    let url: URL
    let copyright: String?
    
    // Match variables to keys.
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    // Initializer.
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
}
