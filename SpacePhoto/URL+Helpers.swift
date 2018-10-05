/* URL+Helpers.swift
   SpacePhoto
   Gets the atronomy picture of the day from NASA website and displays it along with its explanation.
   Created by Nour Yehia on 9/4/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import Foundation

extension URL {

    // Add queries to URL and return a new copy.
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
    
    // Returns a copy of url that uses HTTPS protocol.
    func withHTTPS() -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.scheme = "https"
        return components?.url
    }
}
