//
//  RequestableBase.swift
//  Restofire
//
//  Created by Rahul Katariya on 24/03/16.
//  Copyright © 2016 AarKay. All rights reserved.
//

import Foundation

public protocol RequestableBase: Configurable {
    
    /// The path relative to base URL.
    var path: String { get }
    
}

// MARK: - URL Request
public extension RequestableBase {
    
    public func asUrlRequest() -> URLRequest? {
        let url = [scheme + baseURL, version, path]
            .flatMap { $0 }
            .joined(separator: "/")
        
        let allHeaders = headers + configuration.headers
        var request = try! URLRequest(url: url, method: method, headers: allHeaders)
        
        let allQueryParameters = queryParameters + configuration.queryParameters
        request = try! URLEncoding.queryString.encode(request, with: allQueryParameters)
        
        if let parameters = parameters as? [String: Any] {
            request = try! encoding.encode(request, with: parameters)
        } else if let parameters = parameters as? [Any],
            let encoding = encoding as? ArrayParameterEncoding {
            request = try! encoding.encode(request, with: parameters)
        }
        return request
    }
    
}
