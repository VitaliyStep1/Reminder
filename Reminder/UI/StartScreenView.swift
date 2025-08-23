//
//  StartScreenView.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 23.08.2025.
//

import SwiftUI

struct StartScreenView: View {
  @EnvironmentObject var appConfiguration: AppConfiguration
  @State var isSplashScreenVisible: Bool = true
  
  var body: some View {
    if appConfiguration.isWithSplashScreen && isSplashScreenVisible {
      SplashScreenView(isSplashScreenVisible: $isSplashScreenVisible)
    } else {
      takeMainScreen()
    }
  }
  
  private func takeMainScreen() -> some View {
    MainTabView()
  }
}

#Preview {
  StartScreenView()
}
