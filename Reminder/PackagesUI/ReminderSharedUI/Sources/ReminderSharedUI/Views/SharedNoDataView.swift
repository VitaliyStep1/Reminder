//
//  SharedNoDataView.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 13.11.2025.
//

import SwiftUI

public struct SharedNoDataView: View {
  let systemImageName: String
  let title: String
  
  public init(systemImageName: String, title: String) {
    self.systemImageName = systemImageName
    self.title = title
  }
  
  public var body: some View {
    VStack(spacing: 24) {
      Image(systemName: systemImageName)
        .font(.system(size: 56))
        .foregroundStyle(SharedColor.Accent.primary)
      
      Text(title)
        .font(.body)
        .multilineTextAlignment(.center)
        .foregroundStyle(SharedColor.Text.secondary)
    }
  }
}
