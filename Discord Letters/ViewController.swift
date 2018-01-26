//
//  ViewController.swift
//  Discord Letters
//
//  Created by Guðmundur Halldórsson on 26/01/2018.
//  Copyright © 2018 Guðmundur Halldórsson. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var inputTextField: NSTextField!
    @IBOutlet weak var outputTextField: NSTextField!
    @IBOutlet weak var convertButton: NSButton!
    @IBOutlet weak var copyButton: NSButton!
    @IBOutlet weak var clearAllButton: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.copyButton.isEnabled = false
        self.clearAllButton.isEnabled = false
        self.convertButton.isEnabled = false
        
        self.inputTextField.delegate = self
        self.outputTextField.delegate = self
        
        self.inputTextField.becomeFirstResponder()
        
        UpdateManager.defaultManager.runStartupUpdateCheck()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func onConvertButtonClick(_ sender: Any) {
        if self.inputTextField.text == "" {
            return
        }
        let converter = Converter(text: inputTextField.text)
        self.outputTextField.text = converter.convert()
        self.copyButton.isEnabled = true
    }
    
    @IBAction func onCopyButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func onClearAllButtonClick(_ sender: Any) {
        self.inputTextField.text = ""
        self.outputTextField.text = ""
        
        self.clearAllButton.isEnabled = false
        self.copyButton.isEnabled = false
        self.convertButton.isEnabled = false
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if self.inputTextField.text == "" && self.outputTextField.text == "" {
            // both empty
            if self.clearAllButton.isEnabled {
                self.clearAllButton.isEnabled = false
            }
            if self.copyButton.isEnabled {
                self.copyButton.isEnabled = false
            }
            if self.convertButton.isEnabled {
                self.convertButton.isEnabled = false
            }
        }
        else if self.outputTextField.text == "" {
            // only outputTextField empty
            if self.copyButton.isEnabled {
                self.copyButton.isEnabled = false
            }
            if !self.clearAllButton.isEnabled {
                self.clearAllButton.isEnabled = true
            }
            if !self.convertButton.isEnabled {
                self.convertButton.isEnabled = true
            }
        }
        else if self.inputTextField.text == "" {
            // only inputTextField empty
            if !self.copyButton.isEnabled {
                self.copyButton.isEnabled = true
            }
            if !self.clearAllButton.isEnabled {
                self.clearAllButton.isEnabled = true
            }
            if self.convertButton.isEnabled {
                self.convertButton.isEnabled = false
            }
        }
        else {
            if !self.clearAllButton.isEnabled {
                self.clearAllButton.isEnabled = true
            }
            if !self.copyButton.isEnabled {
                self.copyButton.isEnabled = true
            }
            if !self.convertButton.isEnabled {
                self.convertButton.isEnabled = true
            }
        }
    }


}

