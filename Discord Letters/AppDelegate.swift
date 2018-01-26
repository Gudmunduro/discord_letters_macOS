//
//  AppDelegate.swift
//  Discord Letters
//
//  Created by Guðmundur Halldórsson on 26/01/2018.
//  Copyright © 2018 Guðmundur Halldórsson. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func copyOutput(_ sender: Any) {
        if let viewController = NSApplication.shared().mainWindow?.contentViewController as? ViewController
        {
            if viewController.outputTextField.text == ""
            {
                let alert = NSAlert()
                alert.alertStyle = .warning
                alert.messageText = "Error"
                alert.informativeText = "Output text field is empty"
                alert.addButton(withTitle: "Ok")
                alert.runModal()
                return
            }
            let pasteboard = NSPasteboard.general()
            pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
            pasteboard.setString(viewController.outputTextField.text, forType: NSPasteboardTypeString)
            
            viewController.outputTextField.becomeFirstResponder()
            viewController.outputTextField.selectText(nil)
        }
    }
    
    @IBAction func clearAll(_ sender: Any) {
        if let viewController = NSApplication.shared().mainWindow?.contentViewController as? ViewController
        {
            if viewController.outputTextField.text == "" && viewController.inputTextField.text == ""
            {
                let alert = NSAlert()
                alert.alertStyle = .warning
                alert.messageText = "Error"
                alert.informativeText = "All text fields are empty"
                alert.addButton(withTitle: "Ok")
                alert.runModal()
                return
            }
            viewController.onClearAllButtonClick(viewController.clearAllButton)
        }
    }

}

