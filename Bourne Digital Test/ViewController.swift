//
//  ViewController.swift
//  Bourne Digital Test
//
//  Created by Chirag Chaplot on 29/11/20.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mainObject: MainObject!
    var movieList : [movieCell] = []
    
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
                        //self.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
        
            
        // Do any additional setup after loading the view.
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.movieLabel.text = mainObject.movies[indexPath.row].title.capitalized
        cell.movieImageURL = mainObject.movies[indexPath.row].imageHref
        cell.movieImage.sd_setImage(with: URL(string: cell.movieImageURL ?? ""),
                                      placeholderImage: UIImage(named: "placeholder.png"
                                     ))
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height/2
        cell.movieImage.layer.cornerRadius = cell.movieImage.frame.height/2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieViewController{
            destination.movie = mainObject.movies[tableView.indexPathForSelectedRow!.row]
        }
    }
}

