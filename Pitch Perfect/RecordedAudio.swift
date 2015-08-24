//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Richard Trevivian on 8/24/15.
//  Copyright (c) 2015 Richard Trevivian. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathURL filepathul: NSURL, title titleStr: String) {
        filePathUrl = filepathul
        title = titleStr
    }
    
}