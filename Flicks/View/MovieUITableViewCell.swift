//
//  MovieUITableViewCell.swift
//  Flicks
//
//  Created by nguyen trung quang on 3/12/16.
//  Copyright © 2016 coderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class MovieUITableViewCell: UITableViewCell {

    enum ResolutionImg: String{
        case low = "https://image.tmdb.org/t/p/w45"
        case high = "https://image.tmdb.org/t/p/w342"
        case original = "https://image.tmdb.org/t/p/original"
    }
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MAKR : DisPlay 
    func disPlay(model: MovieObject){
        if (model.poster_path != nil) {
            self.faceImage(model.poster_path!, resolution: ResolutionImg.high)
        }
        lblTitle.text = model.title as? String
        lblOverview.text = model.overview as? String
    }
    
    func faceImage(path: NSString, resolution: ResolutionImg){
        let imageRequest = NSURLRequest(URL: NSURL(string: resolution.rawValue  + (path as String) )!)
                self.imgPoster.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
//                    print("Image was NOT cached, fade in image")
                    self.imgPoster.alpha = 0.0
                    self.imgPoster.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.imgPoster.alpha = 1.0
                    })
                } else {
//                    print("Image was cached so just update the image")
                    self.imgPoster.image = image
                }
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
    }
    
}
