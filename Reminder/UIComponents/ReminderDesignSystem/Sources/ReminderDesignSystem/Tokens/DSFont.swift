//
//  DSFont.swift
//  ReminderDesignSystem
//
//  Created by Vitaliy Stepanenko on 24.11.2025.
//

import SwiftUI

public enum DSFont {
  public static func headline() -> Font {
    .custom(DSFontName.black.resourceName, size: 20)
  }
  
  
  
  public static func body(_ size: CGFloat = 16) -> Font {
    .custom(DSFontName.regular.resourceName, size: size)
  }
  
  public static func title(_ size: CGFloat = 24) -> Font {
    .custom(DSFontName.semiBold.resourceName, size: size)
  }
  
  public static func button(_ size: CGFloat = 17) -> Font {
    .custom(DSFontName.medium.resourceName, size: size)
  }
}
