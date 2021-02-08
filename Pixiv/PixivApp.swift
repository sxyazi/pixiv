//
//  PixivApp.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import SwiftUI
import Cocoa

@main
struct PixivApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(AppService())
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.appearance = NSAppearance(named: .vibrantDark)
        }
    }
}
