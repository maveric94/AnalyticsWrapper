//
//  ContextsStorage.swift
//  
//
//  Created by Anton Protko on 5.06.22.
//

public protocol AnalyticsContext: AnyObject {
    init()
}

public class ContextsStorage {
    private struct ContextWrapper {
        let context: AnalyticsContext
        let hasBindedObject: Bool
        weak var bindedObject: AnyObject?
    }
    
    private var contexts = [ContextWrapper]()
    
    public func get<Context>(contextType: Context.Type) -> Context? where Context: AnalyticsContext {
        return contexts.first {
            return type(of: $0.context) == contextType &&
                (!$0.hasBindedObject || $0.bindedObject != nil)
        }?.context as? Context
    }
    
    public func getAndAddIfNeeeded<Context>(contextType: Context.Type, bindedObject: AnyObject? = nil) -> Context where Context: AnalyticsContext {
        if let existingContext = get(contextType: contextType) {
            return existingContext
        } else {
            let context = contextType.init()
            add(context: context, bindedObject: bindedObject)
            return context
        }
    }
    
    public func add(context: AnalyticsContext, bindedObject: AnyObject? = nil) {
        remove(contextType: type(of: context))
        contexts.append(.init(context: context,
                              hasBindedObject: bindedObject != nil,
                              bindedObject: bindedObject))
    }
    
    public func add(contextType: AnalyticsContext.Type, bindedObject: AnyObject? = nil) {
        add(context: contextType.init(), bindedObject: bindedObject)
    }
    
    public func remove(contextType: AnalyticsContext.Type) {
        contexts.removeAll { type(of: $0.context) == contextType }
    }
}
