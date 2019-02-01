import Flutter
import UIKit

public class SwiftSerhprtPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "serhprt", binaryMessenger: registrar.messenger())
        let instance = SwiftSerhprtPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if ("connect" == call.method) {
            let arguments = call.arguments as! NSDictionary
            serhprt_connect(result: result, name: arguments["name"] as! String, toothAddress: arguments["toothAddress"] as! String)
        }
        else if ("printBarcode" == call.method) {
            let arguments = call.arguments as! NSDictionary
            serhprt_printBarcode(result: result, tur: arguments["tur"] as! Int, barcode: arguments["barcode"] as! String, width: arguments["width"] as! Int, height: arguments["height"] as! Int, position: arguments["position"] as! Int, justification: arguments["justification"] as! Int)
        }
        else if ("printAndFeed" == call.method) {
            let arguments = call.arguments as! NSDictionary
            serhprt_printAndFeed(result: result, distance: arguments["distance"] as! Int)
        }
        else if ("printText" == call.method) {
            let arguments = call.arguments as! NSDictionary
            serhprt_printText(result: result, alignment: arguments["alignment"] as! Int, isBold: arguments["isBool"] as! Bool, isUnderline: arguments["isUnderline"] as! Bool, isAntiWhite: arguments["isAntiWhite"] as! Bool, textsize: arguments["textsize"] as! Int, data: arguments["data"] as! String)
        }
        else if ("isOpened" == call.method) {
            serhprt_isOpened(result: result)
        }
        else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func serhprt_connect(result: FlutterResult, name: String, toothAddress: String) {
        result(String("-1"))
    }
    
    private func serhprt_printBarcode(result: FlutterResult, tur: Int, barcode: String, width: Int,
                                      height: Int, position: Int, justification: Int) {
        result(String("-1"))
    }
    
    private func serhprt_printAndFeed(result: FlutterResult, distance: Int) {
        result(String("-1"))
    }
    
    private func serhprt_printText(result: FlutterResult, alignment: Int, isBold: Bool, isUnderline: Bool,
                                   isAntiWhite: Bool, textsize: Int, data: String) {
        result(String("-1"))
    }
    
    private func serhprt_isOpened(result: FlutterResult) {
        result(Bool(false))
    }
}
