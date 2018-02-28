//
//  MoviesTableViewController.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerMovieClientObserver()
    }

    override func viewDidAppear(_ animated: Bool) {
        MovieClient.fetchUpcoming()
    }
    // MARK: - Table view data source
    
    func registerMovieClientObserver() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init("didfetchMovies"),
                                               object: nil,
                                               queue: OperationQueue.main)
        { (notification) in
            
            if let newMovies = notification.object as? [Movie] {
                self.movies.append(contentsOf: newMovies)
                self.tableView.reloadData()
            }
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        
        
        cell.titleTextLabel.text = movie.title
        cell.posterImageView.downloadedFrom(link: ConfigurationClient.sharedInstance.imageBaseURLPath() + "w342" + movie.posterPath)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        movies.removeAll()
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
