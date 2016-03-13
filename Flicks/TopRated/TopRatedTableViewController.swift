//
//  TopRatedTableViewController.swift
//  Flicks
//
//  Created by nguyen trung quang on 3/12/16.
//  Copyright © 2016 coderSchool. All rights reserved.
//

import UIKit
import MBProgressHUD

class TopRatedTableViewController: UITableViewController, UISearchBarDelegate{
        
    var data = [MovieObject]()
    var dataOriginal = [MovieObject]()
    var pageLoadMore = 1
    var isContinueLoadMore = true
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    var currentSearch = ""
    
    let refrestControl = UIRefreshControl()
    var searchBar = UISearchBar?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstRequest()
        
        let nib = UINib.init(nibName: "MovieUITableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "MovieUITableViewCell")
        self.tableView.backgroundColor = UIColor(colorLiteralRed: 240.0/255.0, green: 187.0/255.0, blue: 90.0/255.0, alpha: 1)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 240.0/255.0, green: 187.0/255.0, blue: 90.0/255.0, alpha: 1)
        
        self.refrestControl.addTarget(self, action:"fetNowPlaying", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(self.refrestControl, atIndex: 0)
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, 0, 80, 80)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        self.tableView.tableFooterView = loadingMoreView!
        
        //add searchBar
        self.searchBar = UISearchBar(frame: (self.navigationController?.navigationBar.frame)!)
        self.navigationItem.titleView = self.searchBar
        self.searchBar?.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieUITableViewCell") as! MovieUITableViewCell
        cell.disPlay(self.data[indexPath.row])
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.redColor()
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    // MARK:- TableVIew Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detail = MovieDetailViewController()
        let model = self.data[indexPath.row]
        detail.model = model
        self.navigationController?.pushViewController(detail, animated: true)
        
        
    }
    // MARK:- Private Method
    func firstRequest(){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.pageLoadMore++
                            let dataResponse = responseDictionary.objectForKey("results") as! NSArray
                            if dataResponse.count == 0 {
                                self.isContinueLoadMore = false
                            }else{
                                self.isContinueLoadMore = true
                            }
                            for  dic in dataResponse {
                                let model = MovieObject(dic: dic as! NSDictionary)
                                self.data.append(model)
                                self.dataOriginal.append(model)
                            }
                            MBProgressHUD.hideHUDForView(self.tableView, animated: true)
                            self.tableView.reloadData()
                    }
                }
        })
        task.resume()
    }
    func fetNowPlaying(){
        self.refrestControl.beginRefreshing()
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)")
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
                            self.pageLoadMore++
                            let dataResponse = responseDictionary.objectForKey("results") as! NSArray
                            if dataResponse.count == 0 {
                                self.isContinueLoadMore = false
                            }else{
                                self.isContinueLoadMore = true
                                self.dataOriginal.removeAll()
                            }
                            for  dic in dataResponse {
                                let model = MovieObject(dic: dic as! NSDictionary)
                                self.dataOriginal.append(model)
                            }
                            self.searchData(self.currentSearch)
                            self.refrestControl.endRefreshing()
                    }
                }
        })
        task.resume()
    }
    
    func loadMoreData(){
        self.refrestControl.beginRefreshing()
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/top_rated?page=\(pageLoadMore)&api_key=\(apiKey)")
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
                            self.pageLoadMore++
                            let dataResponse = responseDictionary.objectForKey("results") as! NSArray
                            if dataResponse.count == 0 {
                                self.isContinueLoadMore = false
                            }else{
                                self.isContinueLoadMore = true
                            }
                            for  dic in dataResponse {
                                let model = MovieObject(dic: dic as! NSDictionary)
                                self.dataOriginal.append(model)
                            }
                            self.loadingMoreView!.stopAnimating()
                            self.isMoreDataLoading = false
                            self.searchData(self.currentSearch)
                            self.refrestControl.endRefreshing()
                    }
                }
        })
        task.resume()
    }
    
    func searchData(string: String){
        self.currentSearch = string
        if (string == "") {
            data = NSArray(array: self.dataOriginal) as! [MovieObject]
        }else{
            let arr = self.dataOriginal.filter {
                ($0.title as! String).rangeOfString(string, options: .CaseInsensitiveSearch) != nil
            }
            self.data = arr
        }
        self.tableView.reloadData()
    }
    // MARK: ScrollView Delegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        // Calculate the position of one screen length before the bottom of the results
        let scrollViewContentHeight = tableView.contentSize.height
        let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
            if isContinueLoadMore && !isMoreDataLoading{
                self.isMoreDataLoading = true
                loadingMoreView!.startAnimating()
                self.loadMoreData()
            }
        }
    }
    
    //MARK :SearchBar Delegate
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchData("")
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        self.searchData(searchText)
    }
    
}
