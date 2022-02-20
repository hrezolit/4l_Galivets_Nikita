//
//  main.swift
//  4l_Galivets_Nikita
//
//  Created by Nikita on 13/2/22.
//
// 1)Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
// 2)Описать пару его наследников TrunkCar и SportCar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
// 3)Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет TrunkCar, а какие – SportCar. Добавить эти действия в перечисление.
// 4)В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
// 5)Создать несколько объектов каждого класса. Применить к ним различные действия.
// 6)Вывести значения свойств экземпляров в консоль.

import Foundation


//MARK: - Main class "Car"

class Car {
    
    enum Color {
        case white
        case yellow
        case orange
        case green
        case blue
        case pink
        case red
        case black
        case silver
    }
    enum Engine {
        case start
        case stop
    }
    enum Windows {
        case open
        case close
    }
    
    enum Trunk {
        case putInTrunk
        case takeFromTrunk
    }
    
    
    let brand: String
    let model: String
    let color: Color
    var isEngineWork: Engine
    var isWindowsOpen: Windows
    var trunkFullness: UInt
    var trunkVolume: UInt {
        didSet {
            if trunkVolume > trunkFullness {
                trunkVolume = oldValue
                print("Trunk is full!")
            } else if trunkVolume == 0 {
                trunkVolume = oldValue
                print("Trunk is empty")
            } else {
                print("Trunk free space (\(trunkVolume) / \(trunkFullness)) liters")
            }
        }
    }
    
    
    init(brand: String,
         model: String,
         color: Color,
         engine: Engine,
         windows: Windows,
         trunkFullness: UInt,
         trunkVolume: UInt)
    {
        self.brand = brand
        self.model = model
        self.color = color
        self.isEngineWork = engine
        self.isWindowsOpen = windows
        self.trunkFullness = trunkFullness
        self.trunkVolume = trunkVolume
    }
    
    
    
    ///Окна Открытие/Закрытие
    func windowsAction(type: Windows) {
        switch type {
        case .open:
            isWindowsOpen = .open
            print("Windows were opened")
        case .close:
            isWindowsOpen = .close
            print("Windows were closed")
        }
    }
    
    ///Багажник Положить/Взять
    func trunkAction(type: Trunk) {
        switch type {
        case .putInTrunk:
            trunkVolume += 50
        case .takeFromTrunk:
            trunkVolume -= 50
        }
    }
    ///Запуск/Остановка двигателя
    func engineAction(type: Engine) {
        switch type {
        case .start:
            isEngineWork = .start
            print("Car engine is power on")
        case .stop:
            isEngineWork = .stop
            print("Car engine is power off")
        }
    }
    ///Пустой метод
    func status() {
        
    }
}


//MARK: - Truck class

final class Truck: Car {
    
    enum  HindcarrigeCondition{
        case set
        case remove
    }
    
    private var isHindcarrigeExist: HindcarrigeCondition
    private let hindcarrigeFullness: UInt
    private var hindcarriageVolume: UInt {
        didSet {
            if hindcarriageVolume > hindcarrigeFullness {
                hindcarriageVolume = oldValue
                print("Hindcarrige is full!")
            } else if hindcarriageVolume == 0 {
                hindcarriageVolume = oldValue
                print("Hindcarrige is empty")
            } else {
                print("Hindcarrige free space (\(hindcarriageVolume) / \(hindcarrigeFullness)) liters")
            }
        }
    }
    
    lazy var overallVolume = hindcarrigeFullness + trunkFullness
    
    init(brand: String,
         model: String,
         color: Color,
         engine: Engine,
         windows: Windows,
         trunkVolume: UInt,
         trunkFullness: UInt,
         hindcarrige: HindcarrigeCondition,
         hindcarrigeFullness: UInt,
         hindcarriageVolume: UInt) {
        
        self.isHindcarrigeExist = hindcarrige
        self.hindcarrigeFullness = hindcarrigeFullness
        self.hindcarriageVolume = hindcarriageVolume
        
        super.init(brand: brand,
                   model: model,
                   color: color,
                   engine: engine,
                   windows: windows,
                   trunkFullness: trunkFullness,
                   trunkVolume: trunkVolume)
    }
    
    override func status() {
        print("""

Car description:

Brand: \(brand)
Model: \(model)
Body color: \(color)
Engind: \(isEngineWork)
Windows: \(isWindowsOpen)
Trunk space: \(trunkFullness)
Hindcarrige space: \(hindcarrigeFullness)

Actions:

""")
    }
}





var truck = Truck(brand: "Tesla",
                  model: "Semi",
                  color: .silver,
                  engine: .stop,
                  windows: .close,
                  trunkVolume: 1000,
                  trunkFullness: 3000,
                  hindcarrige: .set,
                  hindcarrigeFullness: 1500,
                  hindcarriageVolume: 1000)



truck.status()
truck.trunkAction(type: .putInTrunk)
truck.trunkAction(type: .putInTrunk)
truck.trunkAction(type: .putInTrunk)
truck.trunkAction(type: .putInTrunk)
truck.trunkAction(type: .putInTrunk)
truck.engineAction(type: .start)
truck.windowsAction(type: .open)
print(truck.overallVolume)


print("******************************************")

//MARK: - Sportcar class
final class SportCar: Car {
    
    enum isTurboExist {
        case set
        case remove
    }
    enum isBackseatExist {
        case with
        case without
    }
    
    private var maxSpeed: UInt {
        didSet {
            if  maxSpeed < 400 {
                maxSpeed = oldValue
            } else if maxSpeed > 500 {
                maxSpeed = oldValue
            }
        }
    }
    
    let turboBoosting: UInt = 100
    private var turboCondition: isTurboExist
    private let backseat: isBackseatExist
    
    init(brand: String,
         model: String,
         color: Color,
         engine: Engine,
         windows: Windows,
         trunkFullness: UInt,
         trunkVolume: UInt,
         maxSpeed: UInt,
         turbo: isTurboExist,
         backseat: isBackseatExist) {
        
        self.maxSpeed = maxSpeed
        self.turboCondition = turbo
        self.backseat = backseat
        
        super.init(brand: brand,
                   model: model,
                   color: color,
                   engine: engine,
                   windows: windows,
                   trunkFullness: trunkFullness,
                   trunkVolume: trunkVolume)
    }
    
    func setUpTurbo(type: isTurboExist) {
        
        switch type {
        case .set:
            turboCondition = .set
            maxSpeed += turboBoosting
            print("With turbo, max speed up by \(maxSpeed) km/h")
        case .remove:
            turboCondition = .remove
            maxSpeed -= turboBoosting
            print("Without turbo, max speed dicrease by \(maxSpeed) km/h")
            
        }
    }
    
    override func status() {
        print("""

Car description:

Brand: \(brand)
Model: \(model)
Body color: \(color)
Engind: \(isEngineWork)
Max speed: \(maxSpeed)
Turbo: \(turboCondition)
Windows: \(isWindowsOpen)
Backseat: \(backseat)
Trunk space: \(trunkFullness)

Actions:

""")
    }
}


let sportCar = SportCar(brand: "Tesla",
                        model: "Roadster",
                        color: .red,
                        engine: .stop,
                        windows: .close,
                        trunkFullness: 150,
                        trunkVolume: 50,
                        maxSpeed: 400,
                        turbo: .remove,
                        backseat: .without)

sportCar.status()

sportCar.windowsAction(type: .open)
sportCar.engineAction(type: .start)
sportCar.setUpTurbo(type: .set)
sportCar.setUpTurbo(type: .set)
sportCar.setUpTurbo(type: .set)
sportCar.setUpTurbo(type: .set)
sportCar.setUpTurbo(type: .set)
sportCar.setUpTurbo(type: .remove)
sportCar.setUpTurbo(type: .remove)
sportCar.setUpTurbo(type: .remove)
sportCar.setUpTurbo(type: .remove)
sportCar.setUpTurbo(type: .remove)
sportCar.trunkAction(type: .putInTrunk)
sportCar.trunkAction(type: .putInTrunk)

