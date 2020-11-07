import Foundation
import CoreLocation

struct File {
    
    let fURL = Constants.fURL
    
    var delegate: WeatherManagaerDelegate?
    
    func fetch(city: String) {
        let fetchingURL = "\(fURL)&q=\(city)"
        performRequest(with: fetchingURL)
    }
    
    func fetch(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let fetchUrl = "\(fURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: fetchUrl)
    }
    
    func performRequest(with url: String) {
        //cretae url
        if let Url = URL(string: url) {
            //create session
            let session = URLSession(configuration: .default)
            
            //give session a task
            let task = session.dataTask(with: Url) { (data, response, error) in
                if error != nil {
                    self.delegate?.DidFailwITHeRROR(error: error!)
                    return
                }
                if let safedata = data {
                    
                    do {
                        print(try JSONSerialization.jsonObject(with: safedata, options: []))
                    }
                    catch {
                        print(error)
                    }
//                    print(String(data: safedata, encoding: .utf8))
                    
                    if let info = self.parseJSON(data: safedata) {
                        self.delegate?.UpdateWeatherInfo(self, info: info)
                    }
                }
            }
            
            //start session
            task.resume()
        }
        
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeddata = try decoder.decode(DataModel.self, from: data)
            let id = decodeddata.weather[0].id
            let name = decodeddata.name
            let temp = decodeddata.main.temp
            let weatherModel = WeatherModel(id: id, cityname: name, temp: temp)
            return weatherModel
        }
        catch {
            delegate?.DidFailwITHeRROR(error: error)
            return nil
        }
    }
    
    
}
