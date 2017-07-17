//
//  Url+location.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/14/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import Foundation

enum searchType {
    case root
    case nearbySearch(key: String, location: String, radius: String, keyword: String?, name: String?, opennow: String?, type: String?)
    case textSearch(query: String, key: String, location: String?, radius: String?, opennow: String?, type: String? )
    case radarSearch(key: String, location: String, radius: String, keyword: String?, name: String?, opennow: String?, type: String?)
    case placeAutocomplete(input: String, key: String, location: String?, radius: String?)
    case queryAutocomplete(input: String, key: String, location: String?, radius: String?)
    
    func urlService () -> String {
        
                let root = "https://maps.googleapis.com/maps/api/place/"
        
                switch self {
                case .root:
                    return root
                    
                case let .nearbySearch(key, location, radius, keyword, name, opennow, type):
                    let added = "nearbyseach/json?"
                    var url = root + added + "&location=" + location + "&radius=" + radius
                    
                    if let keyword = keyword {
                        url = url + "&keyword=" + keyword
                    }
                    
                    if let name = name {
                        url = url + "&name=" + name
                    }
                    
                    if let opennow = opennow {
                        url = url + "&opennow=" + opennow
                    }
                    
                    if let type = type {
                        url = url + "&type=" + type
                    }
                    
                    return url + "&key=" + key
                    
                case let .textSearch(query, key, location, radius, opennow, type):
                    let added = "textsearch/json?"
                    var url = root + added + "&quesry=" + query
                    
                    if let location = location {
                        url = url + "&loaction=" + location
                    }
                    
                    if let radius = radius {
                        url = url + "&radius=" + radius
                    }
                    
                    if let opennow = opennow {
                        url = url + "&opennow=" + opennow
                    }
                    
                    if let type = type {
                        url = url + "&type=" + type
                    }
                    
                    return url + "&key=" + key
                    
                case let .radarSearch(key, location, radius, keyword, name, opennow, type):
                    let added = "radarsearch/json"
                    var url = root + added + "&loaction=" + location + "&radius=" + radius
                    
                    if let keyword = keyword {
                        url = url + "&keyword=" + keyword
                    }
                    
                    if let name = name {
                        url = url + "&name=" + name
                    }
                    
                    if let type = type {
                        url = url + "&type=" + type
                    }
                    
                    if let opennow = opennow {
                        url = url + "&opennow=" + opennow
                    }
                    
                    return url + "&key=" + key
                    
                case let .placeAutocomplete(input, key, location, radius):
                    let added = "autocomplete/json"
                    var url = root + added + "&input" + input
                    
                    if let location = location {
                        url = url + "&loaction=" + location
                    }
                    
                    if let radius = radius {
                        url = url + "&radius=" + radius
                    }
                    
                     return url + "&key=" + key
                    
                case let .queryAutocomplete(input, key, location, radius):
                    let added = "queryautocomplete/json"
                    var url = root + added + "&input" + input
                    
                    if let location = location {
                        url = url + "&loaction=" + location
                    }
                    
                    if let radius = radius {
                        url = url + "&radius=" + radius
                    }
                    
                    return url + "&key=" + key
                }
                return root
                
            }

    
    
    
}
