//
//  ViewController.swift
//  HomWork_9
//
//  Created by MAC OS  on 06.08.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
  //Создание IBOutlet
  
  @IBOutlet weak var coffeeSegmentControl: UISegmentedControl!
  @IBOutlet weak var sizeCoffeeSegmentControl: UISegmentedControl!
  @IBOutlet weak var sizeSugarSlider: UISlider!
  @IBOutlet weak var ownCupSwitch: UISwitch!
  @IBOutlet weak var sliderLabelCenter: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  
    coffeeSegmentControl.addTarget(self, action: #selector(didSelectCoffee), for: .valueChanged)
    
    sizeCoffeeSegmentControl.addTarget(self, action: #selector(didSelectSize), for: .valueChanged)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //создание Alert с приветствием
    
    let title = "Вас приветствует Coffee, please"
    let message = "Закажешь у нас кофе ?"
    let action = UIAlertAction(title: "Далее", style: .default) { _ in
    }
    showAlert(title: title, message: message, arrayActions: [action])
  }
  
  @objc func didSelectCoffee(param: UISegmentedControl) {
    if param == coffeeSegmentControl {
      let segmentIndex = param.selectedSegmentIndex
      print("user select coffee: \(segmentIndex)")
    }
  }
  
  @objc func didSelectSize(param: UISegmentedControl) {
    if param == sizeCoffeeSegmentControl {
      let segmentIndex = param.selectedSegmentIndex
      print("user select size: \(segmentIndex)")
    }
  }
  
  //Функция создания заказа
  
  func createOrder() -> OrderCoffee {
    //получение индекса "coffeeSegmentControl" (0,1,2)
    let segmentIndexCofee = coffeeSegmentControl.selectedSegmentIndex
    //создание исходного значения
    let coffee = CoffeeType(rawValue: segmentIndexCofee) ?? .latte
    //получение индекса "sizeCoffeeSegmentControl" (0,1,2)
    let indexOfCoffeeSize = sizeCoffeeSegmentControl.selectedSegmentIndex
    //создание исходного значения
    let size = CupSize(rawValue: indexOfCoffeeSize) ?? .small
    
    let isOwnCup = ownCupSwitch.isOn
    
    let order = OrderCoffee(coffee: coffee, size: size, isOwnCup: isOwnCup)
  
    return order
  }
  
  //Фунция получения цены
  
  func getPrice(from order: OrderCoffee) -> String {
    
    let coffeePrice: Int
    
    switch order.coffee {
    case .latte:
      switch order.size {
      case .small: coffeePrice = 3
      case .medium: coffeePrice = 4
      case .big: coffeePrice = 5
      }
    case .cappuccino:
      switch order.size {
      case .small: coffeePrice = 4
      case .medium: coffeePrice = 5
      case .big: coffeePrice = 6
      }
    case .espresso:
      switch order.size {
      case .small: coffeePrice = 5
      case .medium: coffeePrice = 6
      case .big: coffeePrice = 7
      }
    }
    
    var totalPrice = coffeePrice
    
    if order.isOwnCup {
      totalPrice -= 1
    }
    return "\(totalPrice)$"
  }
  
  //Создание IBAction
  
  //Slider Action
  
  @IBAction func sugarSliderAction(_ sender: UISlider) {
    sliderLabelCenter.text = "\(Int(sender.value))"
  }
  
  //Button Action
  
  @IBAction func makeCoffeeButtonAction(_ sender: UIButton) {
    let order = createOrder()
    let price = getPrice(from: order)
    
    let actionYes = UIAlertAction(title: "Подтвердить", style: .default) { [weak self] _ in
      print("Заказ подтвержден")
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let viewController = storyboard.instantiateViewController(withIdentifier: "secondVC")
      self?.navigationController?.pushViewController(viewController, animated: true)
    }
    let actionNo = UIAlertAction(title: "Отказаться", style: .cancel) { _ in
      print("Заказ отменен")
    }
    
    showAlert(title: "Счет", message: "Кофе будет стоить \(price). Вы уверены ?", arrayActions: [actionYes, actionNo])
    
  }
  
  //функция для создания alertController
  
  func showAlert(title: String, message: String, arrayActions: [UIAlertAction]) {
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    
    for action in arrayActions {
      alertController.addAction(action)
    }
  
    self.present(alertController, animated: true, completion: nil)
  }

}
