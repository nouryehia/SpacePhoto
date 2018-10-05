/* PhotoInfoController.swift
   SpacePhoto
   Gets the atronomy picture of the day from NASA website and displays it along with its explanation.
   Created by Nour Yehia on 9/4/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import Foundation

struct PhotoInfoController {
    func getPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        
        // Define query.
        let query: [String: String] = ["api_key": "DEMO_KEY"]
        
        // Define URL based on NASA website and query.
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        let url = baseURL.withQueries(query)!
        
        // Create task that will decode information obtained from website.
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            }
            else {
                print("Either no data was returned, or data was not decoded properly.")
                completion(nil)
            }
        }
        task.resume()
    }
}
