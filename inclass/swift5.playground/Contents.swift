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

//MARK: Closures

// { (parameters) -> returnType in statements}

let roster = ["Evan", "Eva", "Tommy", "Tom", "Sharon"]
//want to sort names in backwards order

//swift sorted method allows for custom sorting of arrays

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

//OLD WAY
var reversedRoster = roster.sorted(by: backward(_:_:))
print(reversedRoster) //sorts in reverse alphabetical order

//Using a closure
var reversedRoster = roster.sorted(by: {(s1:String, s2:String) -> Bool in return s1 > s2})
print(reversedRoster)

var reversedRoster = roster.sorted(by: {s1, s2 in s1 > s2})

var reversedRoster = roster.sorted(by: {$0 > $1})
print(reversedRoster)

var reversedRoster = roster.sorted(by: >)
print(reversedRoster) //not good code but it works

//MARK: Enumerations

enum JobStatus {
    case NotStarted
    case InProgress
    case AlmostThere //if added after this is why we might want a default
    case Done
}

struct Job {
    var title: String
    var status: JobStatus
}

var lab1 = Job(title: "Lab 1", status: JobStatus.NotStarted)

switch lab1.status {
case .Done:
    print("Good Job")
case .InProgress:
    print("I'm working on it")
case .NotStarted:
    print("Get to work")
//because enum we don’t necessarily need a default case, but still want an unknown just in case we modify enum
case .AlmostThere:
    print("So close")
}

//MARK: Errors

enum APIError: Error {
    case Forbidden
    case NotFound
    case RequestTimeout
    case UnknownResponse
}

func checkStatus(status: Int) throws -> String {
//either this function will throw and error or return a string
    switch status {
    case 403: throw APIError.Forbidden
    case 404: throw APIError.NotFound
    case 408: throw APIError.RequestTimeout
    case 200: return "OK"
    default:
        throw APIError.UnknownResponse
    }
}

//pretty good
do {
    let response = try checkStatus(status: 200)
    print(response)
} catch {
    //anything in here is what will execute as soon as a try fails, so if try fails it won’t print the other line and skip to the catch and do this
    //can show error as an alert in actual practice, for here we are printing it
    print(error)
//    print(error.localizedDescription) //can customize localizedDescription and maybe put status of the response but requires more extending
}

//better, catch each specific error that gets thrown
do {
    let response = try checkStatus(status: 403)
    print(response)
} catch APIError.Forbidden {
    print("You don’t have permission to access this resource")
} catch APIError.NotFound {
    print("ould not find resource")
} catch APIError.RequestTimeout {
    print("The request timed out")
} catch APIError.UnknownResponse {
    print("Unknown Response")
} catch {
    print(error)
}

//MARK:  Guard or Early Exit

//related to if statement and exectutes different code based on a boolean statement
//mroe detailsd example in notes

var dividend: Double = 3
var divisor: Double = 2

//guard divisor != 0 {
//    print("Can’t divide by 0!") //guard this, if this fails do
//    return //can also throw error, but generally seen in a function
//}
//return dividend/divisor
//called early exit because used inside of a function and so above example wont work because not in a function

func divide(dividend: Double, divisor: Double) -> Double? {
    guard divisor != 0 else {
        print("Cannot divide by 0!")
        return nil
    }
    return dividend/divisor
}

let result = divide(dividend: 3, divisor: 0)

if let validResult = result {
    print(validResult)
}
