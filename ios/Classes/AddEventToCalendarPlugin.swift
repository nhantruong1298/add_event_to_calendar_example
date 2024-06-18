import Flutter
import UIKit
import EventKitUI

extension Date {
    init(milliseconds:Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}


public class AddEventToCalendarPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "add_event_to_calendar", binaryMessenger: registrar.messenger())
        let instance = AddEventToCalendarPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "add":
            
            do {
                let args = call.arguments as! [String:Any];
                
                let title = args["title"] as! String;
                let dateStart =  Date(milliseconds: args["startDate"] as! Double)
                let dateEnd = Date(milliseconds: args["endDate"] as! Double)
                
                let addEventResult = try add(title: title, startDate: dateStart, endDate: dateEnd)
                
                result(addEventResult);
                
            } catch {
                result(error)
            }
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func add(title: String,startDate: Date,endDate:Date) throws -> Bool{
        var result: Bool = false
        var errorWhenSave: Error? = nil
        let eventStore = EKEventStore()
        
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents { granted, error in
                if granted && error == nil{
                    let event = EKEvent(eventStore: eventStore)
                    event.title = title
                    event.startDate = startDate
                    event.endDate =  endDate
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    
                    
                    do {
                        try eventStore.save(event, span: .thisEvent)
                        
                    } catch {
                        errorWhenSave = error
                    }
                    result = true;
                }else{
                    errorWhenSave = error
                }
            }
        } else {
            eventStore.requestAccess(to: .event) { (granted, error) in
                
                if (granted) && (error == nil) {
                    
                    
                    let event:EKEvent = EKEvent(eventStore: eventStore)
                    
                    event.title = title
                    event.startDate = startDate
                    event.endDate = endDate
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                        result = true
                    } catch let error as NSError {
                        errorWhenSave = error
                    }
                }
                else{
                    errorWhenSave = error
                }
            }
        }
        
        if(errorWhenSave != nil){
            throw errorWhenSave!
        }
        
        
        return result;
    }
}
