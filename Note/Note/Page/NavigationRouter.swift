//
//  NavigationRouter.swift
//  Note
//
//  Created by nyaago on 2026/01/03.
//

import Foundation
import SwiftUI

final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
}

extension EnvironmentValues {
    private struct NavigationKey: EnvironmentKey {
        static let defaultValue = NavigationRouter()
    }

    var navigationRouter: NavigationRouter {
        get { self[NavigationKey.self] }
        set { self[NavigationKey.self] = newValue }
    }
}
