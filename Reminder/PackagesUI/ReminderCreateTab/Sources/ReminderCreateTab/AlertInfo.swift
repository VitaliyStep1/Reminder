//
//  AlertInfo.swift
//  Reminder
//
//  Created by Vitaliy Stepanenko on 03.10.2025.
//

public struct AlertInfo {
  var title: String = "Error"
  let message: String
  var buttonTitle: String = "OK"
  var completion: (() -> Void)?
  
  public init(message: String) {
    self.message = message
  }
  
  public init(message: String, completion: (() -> Void)?) {
    self.message = message
    self.completion = completion
  }
}
