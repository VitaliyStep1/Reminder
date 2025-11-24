//
//  DSNoDataView.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 13.11.2025.
//

import SwiftUI

public struct DSNoDataView: View {
  let systemImageName: String
  let title: String
  
  public init(systemImageName: String, title: String) {
    self.systemImageName = systemImageName
    self.title = title
  }
  
  public var body: some View {
    VStack(spacing: 24) {
      Image(systemName: systemImageName)
        .font(DSFont.iconXLarge())
        .foregroundStyle(DSColor.Accent.primary)
      
      Text(title)
        .font(DSFont.body())
        .multilineTextAlignment(.center)
        .foregroundStyle(DSColor.Text.secondary)
    }
  }
}
