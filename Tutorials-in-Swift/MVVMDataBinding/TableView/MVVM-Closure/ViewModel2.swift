//
//  ViewModel2.swift
//  TableView
//
//  Created by Muhsin Can Yılmaz on 1.04.2023.
//

import Foundation

class ViewModel2{
    
    var onDataReceived: (([String]) -> Void)?
    
    func recieveData(){
        let array = ["Hello World 1", "Hello World 2", "Hello World 3", "Hello World 4", "Hello World 5",]
        onDataReceived?(array)
    }
    
}
