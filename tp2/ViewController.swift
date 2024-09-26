//
//  ViewController.swift
//  tp2
//
//  Created by Tekup-mac-10 on 19/9/2024.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    let array = [Movie(title: "avatar", img: "Avatar"),Movie(title: "Mission Impossible", img:"Mission Impossible"),Movie(title: "Jurrasic Parc", img: "Jurrasic Park")]

    struct Movie {
        let title : String ;
            let img : String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellul = tableView.dequeueReusableCell(withIdentifier: "idcellul", for: indexPath) as! TableViewCell
        let movie = array[indexPath.row]
        cellul.lab.text = movie.title;
        cellul.img.image = UIImage(named: movie.img) ;
        
        return cellul
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
    }


}

