//
//  ViewController.swift
//  TestJSON
//
//  Created by Александр on 4/15/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    private let cellIndentify = "productCell"
    
   
    var exhibit: Exhibit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getExhibitList()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exhibit?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentify) as? ProductTableViewCell else { return UITableViewCell() }
        
        cell.product = exhibit?.list[indexPath.row]
        
        return cell
    }

    
    func getExhibitList() {
        
        let urlData = "https://gist.githubusercontent.com/u-android/41ade05b6ae1133e7e86e9dfd55f1794/raw/bab1c383b0384d1a4c889b399ad7b13ae05634fa/ios%20challenge%20json"
        
        let urlRequest = URLRequest(url: URL(string: urlData)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            
            guard let data = data else { return }
            guard error == nil else {return}
            
            do {
                let result = try JSONDecoder().decode(Exhibit.self, from: data)
                self.exhibit = result
                self.reloadTableView()
            } catch { print(error) }
        }
        task.resume()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

