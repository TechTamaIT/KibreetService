//
//  BaseEndPointProtocol.swift
//  ApiDataStrategy
//
//  Created by 2p on 3/15/22.
//

import Foundation

public protocol BaseEndPointProtocol{
    var httpMethod: HttpMethod {get}
    var parameters: [String: Any]? {get}
    var encoding: Encoding {get}
    var headers: [String: String]{get}
    var path: String {get}
    var baseUrl: String {get}
    var apiVersion: String {get}
    var url: URL {get}
}

public enum Encoding{
    case URL, JSON
}


public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case update = "UPDATE"
}
