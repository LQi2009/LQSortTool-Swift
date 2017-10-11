//
//  LQSortTool.swift
//  Test
//
//  Created by Artron_LQQ on 2017/10/10.
//  Copyright © 2017年 Artup. All rights reserved.
//

import UIKit

/// 排序协议, 只针对需要排序的实例对象
protocol LQSortProtocol {
    
    /// 排序依据, 需要实现此属性
    var sortKey: String{get set}
}

class LQSortTool {

    /// 对实例模型进行排序
    ///
    /// - Parameters:
    ///   - datas: 含有模型实例对象的数组, 需要遵循LQSortProtocol协议
    ///   - ascending: 是否升序
    /// - Returns: 排序完成的数组, 里面是闭包: key: 键, value: 对应一个数组,含有模型实例
    class func sortObjs<T: LQSortProtocol>(_ datas: [T], ascending: Bool = true) -> [(key: String, value: [T])] {
        
        let group = Dictionary(grouping: datas) { (obj: T) -> String in
            
            if let str = checkPolyphone(obj.sortKey) {
                
                return str
            }
            
            let mutableString = NSMutableString(string: obj.sortKey)
            CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
            let string = String(mutableString)
            return String(string.uppercased().first!)
        }
        
        let sort = group.sorted { (key1, key2) -> Bool in
            if ascending {
                return key1.key < key2.key
            }
            return key1.key > key2.key
        }
        
        return sort
    }
    
    /// 对字符串进行分组排序
    ///
    /// - Parameters:
    ///   - datas: 含有字符串的数组
    ///   - ascending: 是否升序
    /// - Returns: 排序完成的数组, 里面是闭包: key: 键, value: 对应一个数组,含有字符串
    class func sort(_ datas: [String], ascending: Bool = true) -> [(key: String, value: [String])] {
        // 对数组内容进行分组
        let group = Dictionary(grouping: datas) { (key: String) -> String in
            
            if let str = checkPolyphone(key) {
                return str
            }
            
            let mutableString = NSMutableString(string: key)
            CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
            let string = String(mutableString)
            return String(string.uppercased().first!)
        }
        // 分组后进行排序
        let sort = group.sorted { (key1, key2) -> Bool in
            if ascending {
                return key1.key < key2.key
            }
            return key1.key > key2.key
        }
        
        return sort
    }
}
// 校验多音字
func checkPolyphone(_ string: String) -> String? {
    
    guard let c = string.first else {
        return nil
    }
    
    let tmp = String(c)
    switch tmp {
    case "解":
        return "X"
    case "仇":
        return "Q"
    case "朴":
        return "P"
    case "查":
        return "Z"
    case "乐":
        return "Y"
    case "单":
        return "S"
    default:
        return nil
    }
}
