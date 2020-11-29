//
//  ViewController.swift
//  Bourne Digital Test
//
//  Created by Chirag Chaplot on 29/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                
                let urlString = "https://www.dropbox.com/s/q1ins5dsldsojzt/movies.json?dl=1"
        
                self.loadJson(fromURLString: urlString) { (result) in
                    switch result {
                    case .success(let data):
                        self.parse(jsonData: data)
                    case .failure(let error):
                        print(error)
                    }
                }
        // Do any additional setup after loading the view.
    }
    
    private func readLocalFile(forName name: String) -> Data? {
            do {
                if let bundlePath = Bundle.main.path(forResource: name,
                                                     ofType: "json"),
                    let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
                }
            } catch {
                print(error)
            }
            
            return nil
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
                let mainObject = try JSONDecoder().decode(MainObject.self, from: jsonData)
                
                print("Title: ", mainObject.title)
                
                for movie in mainObject.movies
                {
                    print("Title:", movie.title)
                    print("IMDB Rating", movie.rating)
                    print("Image Href", movie.imageHref)
                    print("Release Date",movie.releaseDate)
                }
                
                print("===================================")
            } catch {
                print("decode error:- " + error.localizedDescription)
            }
        }
}

