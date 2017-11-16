// HinderApp/HomeViewController.swift
extension HomeViewController {

    func objects(for listAdapter: . . .

    . . . 

    Request.getEvents(params: "queryEvents/los_angeles", completion: { result in
            switch result {
            case .success(let eventArray) :
                DispatchQueue.main.async {
                    items += eventArray as! [ListDiffable]
                    self.adapter.reloadObjects(items)
		    // self.adapter.reloadData(items, completion: { . . . })
                }
            case .failure(let error): print(error)
            }
        })

//HinderApp/Request.swift
class Request{

// Get/Query event request: Async version
    static func getEvents(params: String, completion: @escaping (RequestResult) -> ()){
        var resArray = [Event]()

        let url = URL(string: root + params)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    for item in json {
                        // TO DO: be able to access event data to actually initialize new Event object
                        resArray.append(Event(json: item))
                    }
                    completion(.success(resArray))
                }
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        })
        task.resume()
    }