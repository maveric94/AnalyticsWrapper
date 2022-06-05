//
//  AnalyticsAggregateLogger.swift
//  
//
//  Created by Anton Protko on 5.06.22.
//

public protocol AnalyticsAggregateLogger: AnalyticsEventLogger {
    var loggers: [AnalyticsEventLogger] { get }
}

extension AnalyticsAggregateLogger {
    public func logEvent(name: String, parameters: [String : Any]?) {
        loggers.forEach { $0.logEvent(name: name, parameters: parameters) }
    }
}

