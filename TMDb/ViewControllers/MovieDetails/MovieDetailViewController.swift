//
//  MovieDetailViewController.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 28/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var genreTextLabel: UILabel!
    @IBOutlet weak var releaseDateTextLabel: UILabel!
    @IBOutlet weak var overViewTextView: UITextView!
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movieDetail = movie {

            titleTextLabel.text = movieDetail.title
            posterImageView.downloadedFrom(link: ConfigurationClient.sharedInstance.imageBaseURLPath() + "w342" + movieDetail.posterPath)
            overViewTextView.text = movie?.overview
            
            if let date = movieDetail.releaseDate {
                releaseDateTextLabel.isHidden = false
                releaseDateTextLabel.text = "Release date: " + date.toString()
            } else {
                releaseDateTextLabel.isHidden = true
            }
            
            genreTextLabel.isHidden = true
            genreTextLabel.text = ""
            for genreId in movieDetail.genreIds {
                if let genre = GenreClient.sharedInstance.genresList[genreId] {
                    genreTextLabel.text = genreTextLabel.text! + genre + "; "
                    genreTextLabel.isHidden = false
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
