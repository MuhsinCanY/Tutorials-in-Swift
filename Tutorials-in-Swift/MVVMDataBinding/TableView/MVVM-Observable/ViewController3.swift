//
//  ViewController3.swift
//  TableView
//
//  Created by Muhsin Can Yılmaz on 1.04.2023.
//

import UIKit

class ViewController3: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    
    var viewData = [String]()
    var viewModel = ViewModel3()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.frame
        view.addSubview(tableView)
        
        viewModel.data.bind { data in
            self.viewData = data ?? []
        }
        
        print(viewData) //[]
        
        viewModel.recieveData()
        print(viewData) //["Hello World 1", "Hello World 2",...]
    }


}

extension ViewController3: UITableViewDelegate, UITableViewDataSource{
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



    
