# LQSortTool-Swift

### Objective-C 版本: [LDSortTool](https://github.com/LQi2009/LQSortTool)

Swift4.0 版本的分组排序工具, 可对字符串和实例对象进行排序

# 简介
LQSortTool 是一个可以对一组字符串或一组实例对象进行分组排序的工具, 其中在对实例对象进行排序的时候需要遵循 LQSortProtocol 协议, 并为其属性赋值, 此属性是排序依据, 一定要赋值.

# LQSortProtocol
此协议只针对需要进行排序的模型对象, 其中只定义了一个属性: 
```
var sortKey: String{get set}
```
作为排序的依据, 一定要实现此属性, 并把排序依据字符串赋值给他;
>PS: 对于添加这个排序依据的属性, 开始想到的是写一个NSObject的分类, 添加一个属性, 由于, Extension中只能添加计算属性, 又不想使用Runtime, 增加一些使用成本. 后来想到, 其实只是希望排序的模型能够一定含有这个属性, 并赋值, 所以就使用协议的方式来实现, 强制遵循此协议, 并增加此属性, 也能达到预期的效果.而且如果是Extension的话,只能选择添加NSObject的Extension, 这样的话模型必须是NSObject的子类, 但是有时候我们创建的model并不一定继承自NSObject, 也可能不继承自任何类.

工具中只含有两个类方法, 一个用于对字符串数组进行排序, 一个用于对实例对象进行排序:
##### 对字符串数组排序
```
/// 对字符串进行分组排序
///
/// - Parameters:
///   - datas: 含有字符串的数组
///   - ascending: 是否升序
/// - Returns: 排序完成的数组, 里面是闭包: key: 键, value: 对应一个数组,含有字符串
class func sort(_ datas: [String], ascending: Bool = true) -> [(key: String, value: [String])]
```
这里的返回值数组中是含有的闭包, 含有两个元素, 其一是分组后的名称, 即所属的字母, 另一个是此分组中的元素数组; 如果排序内容不是汉字, 或者首字符不是字母, 则被分组到"#";
使用:
```
let strs = ["张三", "李四", "范冰冰", "赵丽颖", "花千骨", "李白", "范伟", "张三丰", "micle", "单雄信", "解晓东", "单冰冰", "查坤", "朴槿惠", "123", "[[].."]
        
let result = LQSortTool.sort(strs, ascending: true)
        
print(result)
```
此时的输出为:
```
[(key: "#", value: ["123", "[[].."]), 
(key: "F", value: ["范冰冰", "范伟"]), 
(key: "H", value: ["花千骨"]), 
(key: "L", value: ["李四", "李白"]),
(key: "M", value: ["micle"]), 
(key: "P", value: ["朴槿惠"]), 
(key: "S", value: ["单雄信", "单冰冰"]), 
(key: "X", value: ["解晓东"]), 
(key: "Z", value: ["张三", "赵丽颖", "张三丰", "查坤"])]
```

##### 对实例对象(模型)进行排序
对模型对象进行排序, 需要遵循 LQSortProtocol 协议, 并实现其属性, 其值就是排序的依据, 一定要赋值:
```
    /// 对实例模型进行排序
    ///
    /// - Parameters:
    ///   - datas: 含有模型实例对象的数组, 需要遵循LQSortProtocol协议
    ///   - ascending: 是否升序
    /// - Returns: 排序完成的数组, 里面是闭包: key: 键, value: 对应一个数组,含有模型实例
    class func sortObjs<T: LQSortProtocol>(_ datas: [T], ascending: Bool = true) -> [(key: String, value: [T])]
```

这里使用了遵循 LQSortProtocol 协议的泛型, 这样在最终的排序结果中就是传进来的类型, 不需要再进行类型转换;这里的返回值数组中也是含有的闭包, 含有两个元素, 其一是分组后的名称, 即所属的字母, 另一个是此分组中的元素数组; 如果排序内容不是汉字, 或者首字符不是字母, 则被分组到"#";
使用:

假设定义一个类:
```
class People: NSObject, LQSortProtocol {
    var name: String = ""
    var age: Int = 0
    var sortKey: String = ""
}
```
然后排序:
```
let strs = ["张三", "李四", "范冰冰", "赵丽颖", "花千骨", "李白", "范伟", "张三丰", "micle", "单雄信", "解晓东", "单冰冰", "查坤", "朴槿惠", "123", "[[].."]
        
        var peoples: [People] = []
        
        for str in strs {
            let people = People()
            people.name = str
            people.sortKey = str
            people.age = Int(arc4random() % 100)
            
            peoples.append(people)
        }
        
        let rs = LQSortTool.sortObjs(peoples, ascending: true)
        print(rs)
        
        for pe in rs {
            for peop in pe.value {
                print("\(pe.key)--\(peop.name)--\(peop.age)")
            }
        }
```
输出:
```
[(key: "#", value: [<LQSortTool_Swift.People: 0x600000669380>, <LQSortTool_Swift.People: 0x6000006693c0>]), 
(key: "F", value: [<LQSortTool_Swift.People: 0x600000669080>, <LQSortTool_Swift.People: 0x600000669180>]), 
(key: "H", value: [<LQSortTool_Swift.People: 0x600000669140>]), 
(key: "L", value: [<LQSortTool_Swift.People: 0x600000669040>, <LQSortTool_Swift.People: 0x6000006690c0>]), 
(key: "M", value: [<LQSortTool_Swift.People: 0x600000669200>]), 
(key: "P", value: [<LQSortTool_Swift.People: 0x600000669340>]), 
(key: "S", value: [<LQSortTool_Swift.People: 0x600000669240>, <LQSortTool_Swift.People: 0x6000006692c0>]), 
(key: "X", value: [<LQSortTool_Swift.People: 0x600000669280>]), 
(key: "Z", value: [<LQSortTool_Swift.People: 0x600000668f80>, <LQSortTool_Swift.People: 0x600000669100>, <LQSortTool_Swift.People: 0x6000006691c0>, <LQSortTool_Swift.People: 0x600000669300>])]

// 这里打印的是分组后的一些模型属性
#--123--84
#--[[]..--50
F--范冰冰--66
F--范伟--39
H--花千骨--85
L--李四--53
L--李白--86
M--micle--77
P--朴槿惠--95
S--单雄信--34
S--单冰冰--41
X--解晓东--21
Z--张三--45
Z--赵丽颖--20
Z--张三丰--46
Z--查坤--46
```

# 如有帮助, 还请不吝Star & Fork Thanks
# (完)
