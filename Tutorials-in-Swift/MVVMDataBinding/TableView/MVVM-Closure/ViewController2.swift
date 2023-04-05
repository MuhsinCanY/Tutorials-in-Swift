//
//  ViewController2.swift
//  TableView
//
//  Created by Muhsin Can Yılmaz on 1.04.2023.
//

import UIKit

class ViewController2: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    let viewModel = ViewModel2()
    var viewData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.frame
        view.addSubview(tableView)
        
        // ViewModel'den veri geldiğin olmasını istediğimiz işlemleri bu Closure içinde yazıyoruz
        viewModel.onDataReceived = { [weak self] data in
            self?.viewData = data
        }
        
        print(viewData) //[]
        // Bu işlem ile ViewModel'den bize veri getiren fonksiyonu tetikliyoruz.
        viewModel.recieveData()
        
        print(viewData) //["Hello World 1", "Hello World 2",...]
    }


}

extension ViewController2: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let data = viewData[indexPath.row]
        cell.textLabel?.text = data
        return cell
    }
}

