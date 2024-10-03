import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var array: [Movie] = []

    struct Movie {
        let title: String
        let img: String
        let description: String
    }

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        fetchMovies() // Call to fetch movies
    }

    func fetchMovies() {
        let headers = [
            "x-rapidapi-key": "18024fb7bcmshd76a937c328c985p1147d9jsn8273faa1f53e", // Replace with your actual API key
            "x-rapidapi-host": "imdb-top-100-movies.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://imdb-top-100-movies.p.rapidapi.com/")! as URL,
                                           cachePolicy: .useProtocolCachePolicy,
                                           timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    self.array = json.compactMap { dict in
                        guard let title = dict["title"] as? String,
                              let img = dict["image"] as? String,
                              let description = dict["description"] as? String else { return nil }
                        return Movie(title: title, img: img, description: description)
                    }
                    DispatchQueue.main.async {
                        self.table.reloadData() // Update table view on the main thread
                    }
                }
            } catch {
                print("Failed to parse JSON: \(error)")
            }
        }
        dataTask.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idcellul", for: indexPath) as! TableViewCell
        let movie = array[indexPath.row]
        cell.lab.text = movie.title
        
        // Reset the image before loading a new one
        cell.img.image = nil

        // Load the image asynchronously
        if let url = URL(string: movie.img) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    // Ensure the cell is still visible before updating the image
                    if tableView.indexPath(for: cell) == indexPath {
                        cell.img.image = image
                    }
                }
            }.resume()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Details") as? DetailsViewController {
            let selectedMovie = array[indexPath.row]
            vc.labText = selectedMovie.title
            vc.imgName = selectedMovie.img
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
