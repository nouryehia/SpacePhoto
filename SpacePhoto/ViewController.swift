/* ViewController.swift
   SpacePhoto
   Gets the atronomy picture of the day from NASA website and displays it along with its explanation.
   Created by Nour Yehia on 9/4/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import UIKit

// LOOKS EXTREMELY UGLY RIGHT NOW. NEED TO FIGURE OUT HOW TO MAKE IMAGE FILL SCREEN HORIZONTALLY WITHOUT KNOWING ITS HEIGHT (CONSTRAINT ISSUES) IN ORDER TO PUT THE WHOLE IN A SCROLL VIEW.
class ViewController: UIViewController {
    
    // Create photo info controller.
    let photoInfoController = PhotoInfoController()
    
    // Declare outlets.
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    // Called once the view controller has loaded its view hierarchy into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        // If photo can be fetched then update UI.
        photoInfoController.getPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }
    
    // Updates UI based on info obtained from NASA API.
    func updateUI(with photoInfo: PhotoInfo) {
        guard photoInfo.url.withHTTPS() != nil else {return}
        let task = URLSession.shared.dataTask(with: photoInfo.url, completionHandler: { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    self.title = photoInfo.title
                    self.imageView.image = image
                    self.descriptionLabel.text = photoInfo.description
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "© \(copyright)"
                    }
                    else {
                        self.copyrightLabel.isHidden = true
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        })
        task.resume()
    }
}
