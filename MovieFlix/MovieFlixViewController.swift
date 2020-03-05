//
//  MovieFlixViewController.swift
//  MovieFlix
//
//  Created by Bikalp  Timalsina on 2/5/20.
//  Copyright © 2020 Bikalp  Timalsina. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieFlixViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieFlixCell") as! MovieFlixCell
        
        let movie = movies[indexPath.row] //get the movies by row
        let titleOfMovie = movie["title"] as! String //get title of movie
        
        let description = movie["overview"] as! String
        cell.movieTitleLable.text = titleOfMovie
        cell.movieDescriptionLable.text = description
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.pictureView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView! //for table view
    
    var movies = [[String: Any]]() //creation of array of dictionary
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movies = dataDictionary["results"] as! [[String : Any]] //getting a perticular key from the dictionary -> result
            
            self.tableView.reloadData()//calling table view functions again to populate
            
        

           }
        }
        task.resume()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print ("Loading up the deatils screen")
        
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        detailsViewController.movie = movie
        //to not highlight after selecting and coming back to the select
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
