//
//  AnalyticsEvent.swift
//  
//
//  Created by Anton Protko on 5.06.22.
//

public protocol AnalyticsEventInput {
}

public struct AnalyticsEventEmptyInput: AnalyticsEventInput {
    public static let empty = AnalyticsEventEmptyInput()
}

public class AnalyticsEvent<Input: AnalyticsEventInput> {
    public struct Data {
        let name: String
        let parameters: [String: Any]
    }
    
    public let input: Input
    
    public required init(input: Input) {
        self.input = input
    }
    
    public func getEventData() -> Data {
        fatalError()
    }
}
