//
//  MovieViewController.swift
//  Bourne Digital Test
//
//  Created by Chirag Chaplot on 29/11/20.
//

import UIKit
import SDWebImage

class MovieViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieName.text = movie?.title
        movieRating.text = String(describing: movie!.rating ?? 0.0 )
        movieReleaseDate.text = movie?.releaseDate ?? "Release Date Not Found"
        
        
        do
        {
            #if targetEnvironment(simulator)
                // your simulator code
            print("MovieViewController imageHref:- ", movie!.imageHref ?? "No Value")
            #endif
            let url = URL (string: movie!.imageHref ?? "")
            
            if (url != nil)
            {
            imageView.sd_setImage(with: url,
                                  placeholderImage: UIImage(named: "placeholder.png"
                                 ))
            }
            else
            {
                imageView.image = UIImage(named: "placeholder.png")
            }
        }
        catch
        {
            print("MovieViewController Image Download Failed")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
