//
//  Defaults.swift
//  Test
//
//  Created by Пермяков Андрей on 02.11.2022.
//

import Foundation

enum Defaults {
  private static let timerShownKey = "timerShown"
  
  static var timerShown: Bool {
    get { UserDefaults.standard.bool(forKey: timerShownKey) }
    set { UserDefaults.standard.set(newValue, forKey: timerShownKey) }
  }
}
