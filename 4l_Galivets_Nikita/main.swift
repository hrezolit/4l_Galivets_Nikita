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
    var isEngineWork: Bool
    var isWindowsOpen: Bool
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
         engine: Bool,
         windows: Bool,
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
            isWindowsOpen = true
            print("Windows were opened")
        case .close:
            isWindowsOpen = false
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
            isEngineWork = true
            print("Car engine is power on")
        case .stop:
            isEngineWork = false
            print("Car engine is power off")
        }
    }
    ///Пустой метод
    func status() {
        
    }
}


//MARK: - Truck class

final class Truck: Car {
    
    
    private var isHindcarrigeExist: Bool
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
         engine: Bool,
         windows: Bool,
         trunkVolume: UInt,
         trunkFullness: UInt,
         hindcarrige: Bool,
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
                  engine: false,
                  windows: false,
                  trunkVolume: 1000,
                  trunkFullness: 3000,
                  hindcarrige: true,
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
    
    enum Turbo {
        case set
        case remove
    }
    
    private var maxSpeed: UInt {
        didSet {
            if maxSpeed > 500 {
                maxSpeed = 500
            } else if maxSpeed < 400 {
                maxSpeed = oldValue
            }
        }
    }
    private var turbo: Bool
    private let backseat: Bool
    
    init(brand: String,
         model: String,
         color: Color,
         engine: Bool,
         windows: Bool,
         trunkFullness: UInt,
         trunkVolume: UInt,
         maxSpeed: UInt,
         turbo: Bool,
         backseat: Bool) {
        
        self.maxSpeed = maxSpeed
        self.turbo = turbo
        self.backseat = backseat
        
        super.init(brand: brand,
                   model: model,
                   color: color,
                   engine: engine,
                   windows: windows,
                   trunkFullness: trunkFullness,
                   trunkVolume: trunkVolume)
    }
    
    func setUpTurbo(type: Turbo) {
        
        switch type {
        case .set:
            turbo = true
            maxSpeed += 100
            print("With turbo, max speed up by \(maxSpeed) km/h")
        case .remove:
            turbo = false
            maxSpeed -= 100
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
Turbo: \(turbo)
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
                        engine: false,
                        windows: false,
                        trunkFullness: 150,
                        trunkVolume: 50,
                        maxSpeed: 400,
                        turbo: false,
                        backseat: false)

sportCar.status()

sportCar.windowsAction(type: .open)
sportCar.engineAction(type: .start)
sportCar.setUpTurbo(type: .set)
sportCar.setUpTurbo(type: .remove)
sportCar.trunkAction(type: .putInTrunk)
sportCar.trunkAction(type: .putInTrunk)

