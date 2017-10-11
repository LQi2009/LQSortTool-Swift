//
//  ViewController.swift
//  LQSortTool-Swift
//
//  Created by Artron_LQQ on 2017/10/10.
//  Copyright © 2017年 Artup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let strs = ["张三", "李四", "范冰冰", "赵丽颖", "花千骨", "李白", "范伟", "张三丰", "micle", "单雄信", "解晓东", "单冰冰", "查坤", "朴槿惠", "123", "[[].."]
        
        let result = LQSortTool.sort(strs, ascending: true)
        
        print(result)
        var peoples: [People] = []
        
        for str in strs {
            let people = People()
            people.name = str
            people.sortKey = str
            people.age = Int(arc4random() % 100)
            
            peoples.append(people)
        }
        
        for peop in peoples {
            print(peop.sortKey)
        }
        let rs = LQSortTool.sortObjs(peoples, ascending: true)
        print(rs)
        
        for pe in rs {
            for peop in pe.value {
                print("\(pe.key)--\(peop.name)--\(peop.age)")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

