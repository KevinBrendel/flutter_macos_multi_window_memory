import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        initializeFlutter()
        super.awakeFromNib()
    }
    
    public func initializeFlutter() {
        let flutterViewController = FlutterViewController.init()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        
        let methodChannel = FlutterMethodChannel(name: "com.example/multi_window", binaryMessenger: flutterViewController.engine.binaryMessenger)
        methodChannel.setMethodCallHandler(methodCallHandler)
        
        RegisterGeneratedPlugins(registry: flutterViewController)
    }
    
    private func methodCallHandler(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "newWindow":
            newFlutterWindow()
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func newFlutterWindow() {
        let window = MainFlutterWindow()
        window.initializeFlutter()
        window.styleMask = styleMask
        window.setFrame(frame, display: true)
        
        let windowController = NSWindowController()
        windowController.window = window
        windowController.showWindow(self)
    }
    
    override func close() {
//        isReleasedWhenClosed = true // Can cause crash. But reduces NSApp.windows.count
        if let controller = contentViewController as? FlutterViewController {
            controller.engine.shutDownEngine()
        }
        super.close()
    }
}
