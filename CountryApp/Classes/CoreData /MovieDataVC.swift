//
//  MovieListViewController.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 22/08/23.
//

import UIKit


protocol DataPass{
    func dataPass(object : [String : Any] , index:Int , isEdit : Bool)
}

class MovieDataVC: UIViewController{

    var movieList : [MovieInfo] = []
    var delegate : DataPass!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        
    }
}


//MARK: - TableView Delegate Methods

extension MovieDataVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.movieInfo, for: indexPath) as! MovieInfoCell
        cell.movieInfoData = movieList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDic  = ["movieName" : movieList[indexPath.row].movieName ?? "" ,"movieGener" : movieList[indexPath.row].movieGener ?? ""  ,"language" : movieList[indexPath.row].language ?? "" ,"moviePoster":movieList[indexPath.row].moviePoster as Any ] as [String : Any]
        delegate.dataPass(object: movieDic as [String : Any],index: indexPath.row ,isEdit: true)
        self.navigationController?.popViewController(animated: true)
    }
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            movieList = DataBaseHelper.sharedInstace.deleteData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

//MARK: - Methods
extension MovieDataVC {
    func prepareUI(){
        self.tableView.register(MovieInfoCell.nib, forCellReuseIdentifier: MovieInfoCell.movieInfo)
        movieList = DataBaseHelper.sharedInstace.fetchData()
    }
    
    @IBAction func tapToback(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
