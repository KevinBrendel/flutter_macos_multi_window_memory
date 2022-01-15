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
        
        RegisterGeneratedPlugins(registry: flutterViewController)
    }
    
    override func close() {
//        isReleasedWhenClosed = true // Can cause crash. But reduces NSApp.windows.count
        if let controller = contentViewController as? FlutterViewController {
            controller.engine.shutDownEngine()
        }
        super.close()
    }
}
