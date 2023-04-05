//
//  ViewModel3.swift
//  TableView
//
//  Created by Muhsin Can Yılmaz on 1.04.2023.
//

import Foundation

class ViewModel3{
    
    var data: Observable<[String]> = Observable()
    
    func recieveData(){
        let array = ["Hello World 1", "Hello World 2", "Hello World 3", "Hello World 4", "Hello World 5",]
        data.value = array
    }
}

class Observable<T>{
    
    var value: T?{
        didSet{
            _callback?(value)
        }
    }
    
    private var _callback: ((T?) -> Void)?
    
    func bind(_ callback: @escaping (T?) -> Void ){
        self._callback = callback
    }
    
}
