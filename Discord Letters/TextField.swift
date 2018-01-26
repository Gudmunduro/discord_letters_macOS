//
//  TextField.swift
//  Discord Letters
//
//  Created by Guðmundur Halldórsson on 26/01/2018.
//  Copyright © 2018 Guðmundur Halldórsson. All rights reserved.
//

import AppKit

extension NSTextField {
    var text: String {
        get {
            return self.stringValue
        }
        set(value) {
            self.stringValue = value
        }
    }
}
