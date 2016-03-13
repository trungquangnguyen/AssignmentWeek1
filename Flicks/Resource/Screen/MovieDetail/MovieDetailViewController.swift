//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by nguyen trung quang on 3/13/16.
//  Copyright © 2016 coderSchool. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MovieDetailViewController: UIViewController {
    enum ResolutionImg: String{
        case low = "https://image.tmdb.org/t/p/w45"
        case high = "https://image.tmdb.org/t/p/w342"
        case original = "https://image.tmdb.org/t/p/original"
    }
    
    @IBOutlet weak var imgBackgroung: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblOverView: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var subScrollView: UIView!
    var model: MovieObject!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(colorLiteralRed: 240.0/255.0, green: 187.0/255.0, blue: 90.0/255.0, alpha: 1)

        if (model.backdrop_path != nil) {
            self.faceImage(model.backdrop_path!, resolution: ResolutionImg.original)
        }
        
        
        // add Scroll View and SubVIew
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height + 20
        scrollView.contentSize = CGSizeMake(contentWidth, contentHeight)
        let subviewHeight = scrollView.bounds.height
        let frame = CGRectMake(0, 0, contentWidth, subviewHeight).insetBy(dx: 5, dy: 5)
        self.subScrollView = UIView(frame: frame)
        
        //set Value for subview
        lblTitle.text = model.title as? String
        lblReleaseDate.text = model.release_date as? String
        lblOverView.text = model.overview as? String
        lblPopularity.text = model.popularity as? String
        self.setTime()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Private Method
    func setTime(){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/293660?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            
                            let nf = NSNumberFormatter()
                            nf.numberStyle = .NoStyle
                            let time = responseDictionary.objectForKey("runtime") as? NSInteger
                            self.lblTime.text = nf.stringFromNumber(time!)! as String
                    }
                }
        })
        task.resume()
    }
    

    
    func faceImage(path: NSString, resolution: ResolutionImg){
         MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let imageRequest = NSURLRequest(URL: NSURL(string: resolution.rawValue  + (path as String) )!)
        self.imgBackgroung.setImageWithURLRequest(
            imageRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    //                    print("Image was NOT cached, fade in image")
                    self.imgBackgroung.alpha = 0.0
                    self.imgBackgroung.image = image
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.imgBackgroung.alpha = 1.0
                    })
                } else {
                    //                    print("Image was cached so just update the image")
                    self.imgBackgroung.image = image
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
