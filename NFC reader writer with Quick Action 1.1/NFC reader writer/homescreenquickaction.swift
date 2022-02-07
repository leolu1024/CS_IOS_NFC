import SwiftUI

@main

struct HomeScreenQuickActionsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase

    private let quickActionService = QuickActionService()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(quickActionService)
        }
        .onChange(of: scenePhase) { scenePhase in
            switch scenePhase {
            case .active:
                guard let shortcutItem = appDelegate.shortcutItem else { return }
                quickActionService.action = QuickAction(rawValue: shortcutItem.type)
            case .background:
                addDynamicQuickActions()
            default: return
            }
        }
    }

    private func addDynamicQuickActions() {
        UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(
                type: QuickAction.reader.rawValue,
                localizedTitle: "Filter Reader",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(type: .search),
                userInfo: nil
            )
//            UIApplicationShortcutItem(
//                type: QuickAction.website.rawValue,
//                localizedTitle: "Visit Our Website",
//                localizedSubtitle: nil,
//                icon: UIApplicationShortcutIcon(type: .task),
//                userInfo: nil
//            )
            
            
        ]
    }
}
