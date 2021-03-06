 //
//  MovieObject.swift
//  Flicks
//
//  Created by nguyen trung quang on 3/12/16.
//  Copyright © 2016 coderSchool. All rights reserved.
//

import UIKit
class MovieObject: NSObject {
    
    var backdrop_path : NSString?
    var poster_path : NSString?
    var id : NSString?
    var title : NSString?
    var overview : NSString?
    var time : NSString?
    var release_date : NSString?
    var popularity : NSString?
    
    init(dic: NSDictionary){
        self.poster_path = dic.objectForKey("poster_path") as? NSString
        self.backdrop_path = dic.objectForKey("backdrop_path") as? NSString
        self.title = dic.objectForKey("title") as? NSString
        self.overview = dic["overview"] as? NSString
        //        self.time = dic.objectForKey("time") as! NSString
        self.release_date = dic.objectForKey("release_date") as? NSString
        
        let nf = NSNumberFormatter()
        nf.numberStyle = .NoStyle
        let popularity = dic.objectForKey("popularity") as? NSInteger
        let id = dic.objectForKey("id") as? NSInteger
        self.popularity = nf.stringFromNumber(popularity!)!
        self.id = nf.stringFromNumber(id!)!
    }
}
