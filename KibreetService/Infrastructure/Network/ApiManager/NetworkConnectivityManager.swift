//
//  NetworkConnectivityManager.swift
//  GeneralModule
 //
//  Created by Mostafa Muhammad on 24/03/2022.
//

import Foundation
import Network

@available(macOS 10.14, *)
@available(iOS 12.0, *)

public enum NetworkConnectionType {
    case wifi, cellular, ethernet, unknown
}

public class NetworkMonitor {
    public static let shared = NetworkMonitor()

    public let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    public let monitor: NWPathMonitor

    public var isConnected = false
    public var currentConnectionType: NetworkConnectionType?

    public init() {
        monitor = NWPathMonitor()
    }

    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            print("path \(path.status)")
            print("network result \(path.status != .unsatisfied)")
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
        }
        monitor.start(queue: queue)
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
    
    public func getConnectionType(_ path: NWPath){
        var connectionType = NetworkConnectionType.unknown
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }else{
            connectionType = .unknown
        }
        if connectionType != currentConnectionType {
            currentConnectionType = connectionType
            NotificationCenter.default.post(name: .connectivityStatus, object: nil, userInfo: ["ConnectionType" : currentConnectionType ?? .unknown])
        }

    }
}
public extension Notification.Name {
    static let connectivityStatus = Notification.Name(rawValue: "connectivityStatusChanged")
}
