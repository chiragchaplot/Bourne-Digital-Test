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
    
    @IBAction func refreshButtonClicked(_ sender: Any) {
        startLoading()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
                
        startLoading();
        // Do any additional setup after loading the view.
        
    }
    
    //Start to get the JSON
    private func startLoading()
    {
        let urlString = "https://www.dropbox.com/s/q1ins5dsldsojzt/movies.json?dl=1"
        
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                //Fill up the tables
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
            //Load the actual JSON
        private func loadJson(fromURLString urlString: String,
                              completion: @escaping (Result<Data, Error>) -> Void) {
            if let url = URL(string: urlString) {
                let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                    if let data = data {
                        DispatchQueue.main.async {
                            self.tableView.delegate = self
                            self.tableView.dataSource = self
                        }
                        completion(.success(data))
                    }
                }
                
                urlSession.resume()
            }
        }

    //Parse the json
        private func parse(jsonData: Data) {
            do {
                self.mainObject = try JSONDecoder().decode(MainObject.self, from: jsonData)
                
                //Check logs only on simulator
                #if targetEnvironment(simulator)
                print("Title: ", self.mainObject.title)
                
                for movie in self.mainObject.movies
                {
                    print("Title:", movie.title)
                    print("IMDB Rating", movie.rating)
                    print("Image Href", movie.imageHref)
                    print("Release Date",movie.releaseDate)
                    print("===================================")
                }
                #endif
                //Call the main thread to reload data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("parse:- " + error.localizedDescription)
            }
        }
    
    //get number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainObject.movies.count
    }
    
    //Set height of row manually
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //Custom Cell work
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.movieLabel.text = mainObject.movies[indexPath.row].title.capitalized
        cell.movieImageURL = mainObject.movies[indexPath.row].imageHref
        cell.movieImage.sd_setImage(with: URL(string: cell.movieImageURL ?? ""),
                                      placeholderImage: UIImage(named: "placeholder.png"
                                     ))
        //Curved Corners
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height/2
        cell.movieImage.layer.cornerRadius = cell.movieImage.frame.height/2
        return cell
    }
    
    //Cell Click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    //Segue Operation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieViewController{
            destination.movie = mainObject.movies[tableView.indexPathForSelectedRow!.row]
        }
    }
}

