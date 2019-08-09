//
//  OrderCoffee.swift
//  HomWork_9
//
//  Created by MAC OS  on 08.08.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import Foundation

enum CupSize: Int {
  case small = 0
  case medium
  case big
}

enum CoffeeType: Int {
  case latte = 0
  case cappuccino
  case espresso
}

struct OrderCoffee {
  
  let coffee: CoffeeType
  let size: CupSize
  let isOwnCup: Bool
}
