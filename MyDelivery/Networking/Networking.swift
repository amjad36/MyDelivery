//
//  Networking.swift
//  MyDelivery
//
//  Created by Amjad Khan on 31/01/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum MIMEType: String {
    case TextHtml                       = "text/html"
    case ApplicationJSON                = "application/json"
    case ApplicationXWWWFormURLEncoded  = "application/x-www-form-urlencoded"
    case ApplicationXML                 = "application/xml"
    case ApplicationOctetStream         = "application/octet-stream"
    case ImagePNG                       = "image/png"
    case ImageJPEG                      = "image/jpeg"
    case ImageANY                       = "image/*"
    case ApplicationJSONWithUTF8        = "application/json; charset=utf-8"
    case Gzip                           = "gzip"
}

struct HTTPHeader {
    static let Accept                   = "Accept"
    static let ContentType              = "Content-Type"
    static let CustomContentType        = "Contenttype"
    static let AcceptEncoding           = "Accept-Encoding"
    static let APIKey                   = "x-api-key"
    static let Authorization            = "Authorization"
    static let Authheader               = "authheader"
}


enum HTTPResponseCode : Int {
    case OK                             = 200
    case ContactSuccessfullyCreated     = 201
    case Error                          = 400
    case NotFound                       = 404
    case ValidationErrors               = 422
    case InternalServerError            = 500
}

class NetworkController {
    
    let defaultTimeoutInterval: TimeInterval = 30
    
    func loadRequest(urlStr: String, body : Data? = nil, method: HTTPMethod = .GET, mimeType: MIMEType = .ApplicationJSON, completion: @escaping (_ data: Data?, _ error: NSError?) -> Void) {
        
        guard let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            Logger.debugLog("URL format is not correct.")
            return
        }
        
        guard let url = URL(string: urlString) else {
            Logger.debugLog("Could not make url.")
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: defaultTimeoutInterval)
        urlRequest.httpBody = body
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(mimeType.rawValue, forHTTPHeaderField: HTTPHeader.ContentType)
        
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil, nil)
                return
            }
            completion(data, nil)
        })
        task.resume()
    }
    
}
