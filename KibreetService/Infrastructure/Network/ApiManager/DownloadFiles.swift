//
//  DownloadFiles.swift
//  SFC
//
//  Created by Ahmed Labeeb on 18/09/2022.
//

import Foundation
import UIKit

class DownloadFilesHelper{
    
    static func saveFile(urlString: String, completion: @escaping (Result<URL,Error>)->()) {
        guard let urlString = urlString.decodeUrl(), let url = URL(string: urlString) else{
            completion(.failure(ValidationError.init(message: "LocalizationKeys.urlNotValid.localized")))
            return
        }
        let fileName = String((url.lastPathComponent)) as NSString
        guard let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return
        }
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
        if FileManager.default.fileExists(atPath: destinationFileUrl.path) {
            print("🍎 file exists")
            try? FileManager.default.removeItem(at: destinationFileUrl)
        }
        //Create URL to the source file you want to download
        let fileURL = URL(string: urlString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                        //Show UIActivityViewController to save the downloaded file
                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                        for index in 0..<contents.count {
                            if contents[index].lastPathComponent == destinationFileUrl.lastPathComponent {
                                completion(.success(contents[index]))
                            }
                        }
                    }
                    catch (let error) {
                        completion(.failure(error))
                    }
                } catch (let writeError) {
                    completion(.failure(writeError))
                }
            } else {
                completion(.failure(error!))
            }
        }
        task.resume()
    }
}
