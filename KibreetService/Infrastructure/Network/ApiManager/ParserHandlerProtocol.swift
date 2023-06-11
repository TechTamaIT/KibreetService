//
//  ParserHandlerProtocol.swift
//  ApiDataStrategy
//
//  Created by 2p on 3/15/22.
//

import Foundation

public protocol ParserHandlerProtocol {
    //func parserHandler<T: Codable>(parsefrom json:[String : Any]) -> Result<T,Error>
    func ParserHandler<T: Codable>(parsefrom data:Data) -> Result<T,Error>
}

class DefaultParser: ParserHandlerProtocol {
    
    func ParserHandler<T: Codable>(parsefrom data:Data) -> Result<T,Error> {
        let decoder = JSONDecoder.init()
        do{
            let object = try decoder.decode(T.self, from: data)
            return .success(object)
        }
        catch{
            return .failure(error)
        }
    }
}
