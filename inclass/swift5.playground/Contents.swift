import UIKit

//MARK: String Literals

let literal = """
    this string is pre-formatted
and it spans
    multiple lines
"""

print(literal)


//MARK: Raw Strings

let raw = #"I don't want to go to "class" I want to "sleep""#

print(raw)

let unreadMessage = 3
let rawInter = #"You have \#(unreadMessage) unread messages"#

let names = "Ariel, Danny, Aileen, David"
let aileenRegEx = "\\bAileen\\b" // \b is a word boundry and bc a string need to escape the \b so becomes \\b and add quotes

let aileenRange = names.range(of: aileenRegEx, options: .regularExpression)
print(names[aileenRange!])

let rawLiteral = #"""
Literally such a raw string
   Yeah an dsuper literal
"""#

print(rawLiteral)

//MARK: Boolean Toggle
var boolean: Bool = false
print(boolean)

boolean.toggle()
print(boolean)


//MARK: Custom string interpolation
struct MenuItem {
    var name: String
    var price: Double
    
}

let coffee = MenuItem(name: "Coffee", price: 3.00)
let tea = MenuItem(name: "Tea", price: 2.55)

print("""
Beverages:
\(coffee)
\(tea)
""")
//doesnt print nicley for users

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: MenuItem) {
        appendLiteral("\(value.name).......$\(value.price)")
    }
    //mutating used for changing a member of a struct
} //entending is customizing/adding on to a class


//MARK: Optionals

var score: Int? //? tells it it is an optional, if you dont assign it a value it gets no value
print(score) //pritning before doing anything returns nil

score = 80
print(score!) //! unwrapps it and means we are certain there is a value there

//better way to do instead of just force unwrap
if score != nil {
    print(score!)
} //check if optional is nil first

//optional binding
if let currentScore = score { //swift specifici, check if this is nil and if isnt goes into block, if nil continues with rest of code past function
    print(currentScore)
}

let myScore = score ?? 0
print(myScore)

//MARK: Optional Chaining
//gracefully access optional members properties

struct Developer {
    var name: String
    var app: App?
}

struct App {
    var title: String
}

//let isaac = Developer(name: "Isaac")
//print(isaac.app!.title) //going to crash program bc app optional and

let nate = Developer(name: "Nate", app: App(title: "First"))
//let nate = Developer(name: "Nate")
//print(nate.app!.title)

if let app = nate.app?.title { //nate.app?.title is chaining
    print(app)
} else {
    print("This developer has no apps.")
}
//so if nate has an app and the app has a title, then lets go and print this

//MARK: Custom type casting

class Commuter {
    var efficiency: Int
    init(efficiency: Int) {
        self.efficiency = efficiency
    }
}

class Bike: Commuter {
    var type: String
    init(efficiency: Int, type: String) {
        self.type = type
        super.init(efficiency: efficiency)
    }
}

class Skates: Commuter {
    var brand: String
    
    init(efficiency: Int, brand: String){
        self.brand = brand
        super.init(efficiency: efficiency)
    }
}

var myCommuters = [Bike(efficiency: 8, type: "road"), Bike(efficiency: 6, type: "mountain"), Skates(efficiency: 4, brand: "Rollerblade"), Skates(efficiency: 2, brand: "K2")]
//mixed array of bikes and skaets
//myCommuters is an array of the super, so commuter and not bike or skates

var bikeCount = 0
var skatesCount = 0

for commuter in myCommuters {
    if commuter is Bike {
        bikeCount += 1
    }
    if commuter is Skates {
        skatesCount += 1
    }
}

print(bikeCount)
print(skatesCount)

//downcasting: if we have  a bike and want to access specific type we want to downcast so we can access those when we need to
for commuter in myCommuters {
    if let myBike = commuter as? Bike {
        //if we can downcast commmuter as a bike type assign it to myBIke
        print("Bike is a \(myBike.type) bike")
    }
    if let mySkates = commuter as? Skates {
        print("These skates are \(mySkates.brand) brand")
    }
}
