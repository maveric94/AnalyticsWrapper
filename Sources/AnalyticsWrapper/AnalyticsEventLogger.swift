//
//  AnalyticsEventLogger.swift
//
//
//  Created by Anton Protko on 5.06.22.
//


public protocol AnalyticsEventLogger {
    func logEvent(name: String, parameters: [String: Any]?)
}

extension AnalyticsEventLogger {
    func logEvent<Event, Input>(type: Event.Type, input: Input) where Event: AnalyticsEvent<Input> {
        logEvent(type.init(input: input))
    }
    
    func logEvent<Event>(type: Event.Type) where Event: AnalyticsEvent<AnalyticsEventEmptyInput> {
        logEvent(type.init(input: .empty))
    }
    
    func logEvent<Event, Input>(_ event: Event) where Event: AnalyticsEvent<Input> {
        let eventData = event.getEventData()
        logEvent(name: eventData.name, parameters: eventData.parameters)
    }
}
