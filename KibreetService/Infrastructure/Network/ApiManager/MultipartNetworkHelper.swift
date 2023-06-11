//
//  MultipartNetworkHelper.swift
//  SFC
//
//  Created by Ahmed Labeeb on 13/09/2022.
//

import Foundation
import Alamofire
import Combine

class ApiMultipartHelper {
    
    var errorHandler: ErrorHandlerProtocol!
    
    public required init(parser: ParserHandlerProtocol, errorHandler: ErrorHandlerProtocol) {
        self.errorHandler = errorHandler
    }
    
    public init() {
    }
    
    public func apiCall<T: Codable>(endPoint: BaseEndPointProtocol , attachments: [Attachment]) -> Future<T,Error>  {
        let url = endPoint.url
        let parameters: [String:Any]? = {
            if let parameters = endPoint.parameters{
                return NetworkParameterHelper.convertParameterArabicValuesToEnglish(of: parameters)
            }
            return nil
        }()
        let headers = HTTPHeaders.init(endPoint.headers)
        //let method = HTTPMethod.init(rawValue: endPoint.httpMethod.rawValue)
        print("✅ parameters:  \(parameters ?? [:])")
        print("✅ attachments:  \(attachments)")
        print(NetworkMonitor.shared.isConnected)
        return Future { promise in
//            guard  NetworkMonitor.shared.isConnected else{
//                promise(.failure(ValidationError(message: "No internet connection")))
//                return
//            }
            
            _ = AF.upload(multipartFormData: { mpfd in
                
                if !attachments.isEmpty{
                    for i in 0..<attachments.count{
                        let attachment = attachments[i]
                        mpfd.append(
                            attachment.data,
                            withName: attachment.keyName,
                            fileName: "\(attachment.keyName)\(i)\(attachment.mimeType.extension)",
                            mimeType: attachment.mimeType.key
                        )
                        print("Append mpdf object: ",attachment.keyName,"\(attachment.keyName)\(i)\(attachment.mimeType.extension)",attachment.mimeType.key)
                    }
                }
                if let params = parameters{
                    for (key, value) in params {
                        mpfd.append("\(value)".data(using: .utf8)!, withName: key)
                        
                    }
print("mpfd after -> \(mpfd)")
                }
                
            }, to: url, headers: headers)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        #if DEBUG
                        let url = response.request?.url?.absoluteString
                        let string = String.init(data: data, encoding: .utf8)
                        print("✅ URL:  \(url ?? "❌")")
                        print("✅ Response \(string ?? "❌")")
                        
                        #endif
                        let parserResult: Result<T,Error> = self.parserHandler(parsefrom: data)
                        switch parserResult {
                        case .success(let object):
                            promise(.success(object))
                        case .failure(let error):
                            promise(.failure(error))
                            #if DEBUG
                            print(" Parsing Fail: \(error)")
                            #endif
                        }
                        break
                    case .failure(let error):
                        promise(.failure(error))
                        #if DEBUG
                        print(error)
                        #endif
                    }
                }
        }
    }
    
    
    
    func parserHandler<T: Codable>(parsefrom data:Data) -> Result<T,Error> {
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



struct Attachment{
    let data: Data
    let keyName: String
    let mimeType: MimeType
    enum MimeType{
        case image
        
        var `extension`: String{
            switch self {
            case .image:
                return ".jpeg"
            }
        }
        
        var key: String{
            switch self {
            case .image:
                return "image/jpeg"
            }
        }
    }
}
