import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    @IBAction
    func newWindow(_ sender: Any) {
        if let referenceWindow: NSWindow = NSApp.keyWindow {
            let window = MainFlutterWindow()
            window.initializeFlutter()
            window.styleMask = referenceWindow.styleMask
            window.setFrame(referenceWindow.frame, display: true)
            window.title = String(NSApp.windows.count)
            
            let windowController = NSWindowController()
            windowController.window = window
            windowController.showWindow(nil)
        }
    }
}
