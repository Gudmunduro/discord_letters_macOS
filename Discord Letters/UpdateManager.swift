//
//  UpdateManager.swift
//  Discord Letters
//
//  Created by Guðmundur Halldórsson on 26/01/2018.
//  Copyright © 2018 Guðmundur Halldórsson. All rights reserved.
//

import AppKit

class UpdateManager: NSObject, NSUserNotificationCenterDelegate {
    
    let currentVersion = "1.0"
    static let defaultManager = UpdateManager()
    
    override init()
    {
        super.init()
        NSUserNotificationCenter.default.delegate = self
    }
    
    func showUpdateAvaibleNotification()
    {
        let notification = NSUserNotification()
        notification.title = "Discord_letters"
        notification.informativeText = "Update available"
        notification.soundName = NSUserNotificationDefaultSoundName
        notification.actionButtonTitle = "Update now"
        notification.otherButtonTitle = "Later"
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func runStartupUpdateCheck()
    {
        self.checkForUpdate(onLoad: { available in
            if available {
                DispatchQueue.main.async {
                    self.showUpdateAvaibleNotification()
                }
            }
        })
    }
    
    func checkForUpdate(onLoad: ((Bool) -> Void)?)
    {
        let rq = NetworkRequest(url: "version.php", params: "", onLoad: { data in
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String] {
                    if self.compareVersions(oldVersion: self.currentVersion, newVersion: json["version"]!) {
                        onLoad!(true)
                        return
                    }
                }
                onLoad!(false)
            }
            catch {
                onLoad!(false)
            }
        })
        rq.send()
    }
    
    private func compareVersions(oldVersion: String, newVersion: String) -> Bool
    {
        let oldVersionNumbers = oldVersion.components(separatedBy: ".")
        let newVersionNumbers = newVersion.components(separatedBy: ".")
        for i in 0...newVersionNumbers.count - 1{
            if oldVersionNumbers.count < i {
                return true
            }
            if Int(newVersionNumbers[i])! > Int(oldVersionNumbers[i])! {
                return true
            }
            if Int(oldVersionNumbers[i])! > Int(newVersionNumbers[i])! {
                return false
            }
        }
        return false
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        switch notification.activationType {
        case .actionButtonClicked:
            let url = URL(string: "https://files.gudmunduro.com/discord_letters/discord_letters.zip")
            NSWorkspace.shared().open(url!)
        default: break
        }
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter,
                                shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
}
