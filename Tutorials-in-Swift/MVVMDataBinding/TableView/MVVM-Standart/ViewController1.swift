//
//  ViewController.swift
//  TableView
//
//  Created by Muhsin Can Yılmaz on 1.04.2023.
//

import UIKit

class ViewController1: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    let viewModel = ViewModel1()
    var viewData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.frame
        view.addSubview(tableView)
        
        print(viewModel.data) //[]
        // Eğer bu fonksiyonu çağırmazsak verilerde herhangi bir değişim olmayacaktır.
        viewModel.recieveData()
        
        print(viewModel.data) //["Hello World 1", "Hello World 2",...]
        // Burada ViewModel'den gelen veri ile View'daki veriler birbirlerine bağlıyoruz.
        viewData = viewModel.data
    }


}

extension ViewController1: UITableViewDelegate, UITableViewDataSource{
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
