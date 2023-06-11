//
//  HomeEndPoint.swift
//  SFC
//
//  Created by Ahmed Labeeb on 31/07/2022.
//

import Foundation


enum HomeEndPoint: BaseEndPointProtocol {
    
    
    case getImageSlider(fcmToken: String)
    case getNotifications(fcmToken: String,page: Int)
    case postNotificationToken(token: String, isEnabled: Bool)
    case updateNotificationsLanguage(token: String, language: String)
    case deleteAccount(password: String)
    case getUpdateStatus(version: UInt8, platform: String)
    
    var httpMethod: HttpMethod{
        switch self {
        case .getNotifications, .getImageSlider, .deleteAccount, .postNotificationToken, .updateNotificationsLanguage:
            return .post
        case .getUpdateStatus:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getImageSlider(let fcmToken):
            return [
                "pushNotificationToken": fcmToken
            ]
        case .getNotifications(let fcmToken,let page):
            return ["pushNotificationToken":fcmToken, "page": page, "count": 10]
        case .postNotificationToken(let token, let isEnabled):
            return [
                "TokenId": token,
                "IsEnabled": isEnabled
            ]
        case .updateNotificationsLanguage(let token, let language):
            return [
                "language": language,
                "notificationTokenId": token
            ]
        case .deleteAccount(let password):
            return ["password": password]
        case .getUpdateStatus(version: let version, platform: let platform):
            return ["versionNumber": version, "plateformName": platform]
        }
    }
    
    var encoding: Encoding {
        switch self {
        case .getImageSlider, .getNotifications, .postNotificationToken, .updateNotificationsLanguage:
            return .JSON
        case .deleteAccount, .getUpdateStatus:
            return .URL
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .getImageSlider, .getNotifications, .postNotificationToken, .updateNotificationsLanguage, .deleteAccount:
            return authorizedHeaders
        default:
            return defaultHeaders
        }
    }
    
    var path: String {
        switch self {
        case .getImageSlider:
            return "Home/GetData"
        case .getNotifications:
            return "Notifications"
        case .deleteAccount:
            return "User/DeleteAccount"
        case .postNotificationToken:
            return "Notifications/PostNotificationToken"
        case .updateNotificationsLanguage:
            return "Notifications/SwitchLanguageInNotificationToken"
        case .getUpdateStatus:
            return "Home/GetAppConfiguration"
        }
    }
    
    var baseUrl: String {
        return "Links.production"
    }
    
    var apiVersion: String{
        return "1.0"
    }
    
    var url: URL {
        return URL.init(string: baseUrl + path)!
    }
    
    
    
}
