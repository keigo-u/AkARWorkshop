import UIKit

// MARK: - 定数と変数
let a: String = "constant"
var b: String = "variable"
b  = "changed"

// MARK: 型推論
let d = ["key": 123]

// MARK: 配列、辞書、範囲
let array: [Int] = [1, 2, 3]
let dictionary: [String: Int] = ["Key1": 1, "Key2": 2]

let range = 1..<4
for i in range {
    print(i)
}

let range2 = 1...4
for i in range2 {
    print(i)
}

// MARK: - オプショナル
var optional: Int?
optional = nil

// MARK: if-let文
if let unwrapedValue = optional {
    print(unwrapedValue)
} else {
    print("optional is nil")
}

// MARK: guard文
func guardTest(_ optional: Int?) {
    guard let unwrapedValue = optional else { return }
    unwrapedValue
}
guardTest(optional)

// MARK: ??演算子
let unwrapedValue = optional ?? 2
unwrapedValue

// MARK: 強制アンラップ
optional! // 値がない場合はエラー

// オプショナルチェイン
let optionalString: String? = "Hello"
optionalString?.count

// MARK: - 構造体、クラス、列挙型
struct Student {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

var student1 = Student(name: "Unuma")
var student2 = student1
student1.name = "Yabiku"
student1.name
student2.name

class Teacher {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

var teacher1 = Teacher(name: "Unuma")
var teacher2 = teacher1
teacher1.name = "Yabiku"
teacher1.name
teacher2.name

// MARK: ストアドプロパティ
struct Sample {
    var hoge = 123
    let fuga = 456
}

let sample = Sample()
sample.hoge // 123

// MARK: コンピューテッドプロパティ
struct Temperature {
    var celsius: Double = 0.0
    var fahrenheit: Double {
        get {
            return (9.0 / 5.0) * celsius + 32.0
        }
        set {
            celsius = (5.0 / 9.0) * (newValue - 32.0)
        }
    }
}

var temperature = Temperature()
temperature.celsius
temperature.fahrenheit

temperature.celsius = 20
temperature.celsius
temperature.fahrenheit

temperature.fahrenheit = 32
temperature.celsius
temperature.fahrenheit
