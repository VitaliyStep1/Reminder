//
//  Styles.swift
//  ReminderSharedUI
//
//  Created by Vitaliy Stepanenko on 12.11.2025.
//

import SwiftUI

public class Styles {
  public static let shared = Styles()
  private init() {}
  
  let mainButtonStyles = MainButtonStyles()
  
  public enum Padding {
    public struct ScreenPadding: Hashable {
      public static let horizontal: CGFloat = 16
      public static let top: CGFloat = 8
      public static let bottom: CGFloat = 24
    }
  }
  
  public struct MainButtonStyles {
    public let font: Font = .headline
    public let frameMaxWidth: CGFloat = .infinity
  }
}
