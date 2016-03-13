//
//  TopRatedTableViewController.swift
//  Flicks
//
//  Created by nguyen trung quang on 3/12/16.
//  Copyright © 2016 coderSchool. All rights reserved.
//

import UIKit

class TopRatedTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetNowPlaying()
        
        let nib = UINib.init(nibName: "MovieUITableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "MovieUITableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieUITableViewCell") as! MovieUITableViewCell
        return cell
    }
    
    // MARK:- Private Method
    func fetNowPlaying(){
//        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
//        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
//        let request = NSURLRequest(
//            URL: url!,
//            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
//            timeoutInterval: 10)
//        
//        let session = NSURLSession(
//            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
//            delegate: nil,
//            delegateQueue: NSOperationQueue.mainQueue()
//        )
//        
//        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
//            completionHandler: { (dataOrNil, response, error) in
//                if let data = dataOrNil {
//                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
//                        data, options:[]) as? NSDictionary {
//                            print("response: \(responseDictionary)")
//                            
//                    }
//                }
//        })
//        task.resume()
    }
    
}
