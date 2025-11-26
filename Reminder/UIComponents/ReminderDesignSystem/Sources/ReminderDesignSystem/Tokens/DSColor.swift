import SwiftUI

public enum DSColor {
  public enum Accent {
    public static let primary = Color.accentColor
    public static let gradientStart = Color.accentColor
    public static let gradientEnd = Color.accentColor.opacity(0.7)
    public static let gradientStrong = Color.accentColor.opacity(0.8)
    public static let highlight = Color.accentColor.opacity(0.12)
    public static let shadow = Color.accentColor.opacity(0.3)
    public static let shadowSoft = Color.accentColor.opacity(0.25)
  }

  public enum Category {
    public static let icon = Color.blue
    public static let gradientStart = Color.blue
    public static let gradientEnd = Color.indigo
    public static let shadow = Color.blue.opacity(0.3)
  }

  public enum Danger {
    public static let primary = Color.red
    public static let gradientStart = Color.red.opacity(0.85)
    public static let gradientEnd = Color.red
    public static let shadow = Color.red.opacity(0.2)
  }

  public enum Background {
    public static let primary = Color(.systemBackground)
    public static let secondary = Color(.secondarySystemBackground)
    public static let grouped = Color(.systemGroupedBackground)
    public static let groupedSecondary = Color(.secondarySystemGroupedBackground)
  }

  public enum Shadow {
    public static let extraLight = Color.black.opacity(0.05)
    public static let light = Color.black.opacity(0.06)
    public static let medium = Color.black.opacity(0.08)
    public static let heavy = Color.black.opacity(0.1)
  }

  public enum Text {
    public static let primary = Color.primary
    public static let secondary = Color.secondary
    public static let inverse = Color.white
    public static let blue = Color.blue
  }
}
