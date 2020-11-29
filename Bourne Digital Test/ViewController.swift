//
//  ViewController.swift
//  Bourne Digital Test
//
//  Created by Chirag Chaplot on 29/11/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mainObject: MainObject!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                
                let urlString = "https://www.dropbox.com/s/q1ins5dsldsojzt/movies.json?dl=1"
        
                self.loadJson(fromURLString: urlString) { (result) in
                    switch result {
                    case .success(let data):
                        self.parse(jsonData: data)
                        //Fill up the tables
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                    case .failure(let error):
                        print(error)
                    }
                }
        
            
        // Do any additional setup after loading the view.
        self.tableView.reloadData()
        
        
        
    }
    
    
            
        private func loadJson(fromURLString urlString: String,
                              completion: @escaping (Result<Data, Error>) -> Void) {
            if let url = URL(string: urlString) {
                let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                    if let data = data {
                        completion(.success(data))
                    }
                }
                
                urlSession.resume()
            }
        }

        private func parse(jsonData: Data) {
            do {
                self.mainObject = try JSONDecoder().decode(MainObject.self, from: jsonData)
                
                print("Title: ", self.mainObject.title)
                
                for movie in self.mainObject.movies
                {
                    print("Title:", movie.title)
                    print("IMDB Rating", movie.rating)
                    print("Image Href", movie.imageHref)
                    print("Release Date",movie.releaseDate)
                    print("===================================")
                }
                
                self.tableView.reloadData()
                
                
            } catch {
                print("parse:- " + error.localizedDescription)
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainObject.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = mainObject.movies[indexPath.row].title.capitalized
        return cell
    }
}

