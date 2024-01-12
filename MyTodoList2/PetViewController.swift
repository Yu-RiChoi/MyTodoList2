//
//  PetViewController.swift
//  MyTodoList2
//
//  Created by 최유리 on 1/12/24.
//

import UIKit

class PetViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCatImage()
    }
    
    @IBAction func didTap(_ sender: Any) {
        loadCatImage()
    }
    

    private func loadCatImage() {
        let urlString = "https://api.thecatapi.com/v1/images/search"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            if let error = error {
                print("에러 발생!!!")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard let cats = try? jsonDecoder.decode([Cat].self, from: data),
                  let cat = cats.first
            else {
                return
            }
            
            guard let url = URL(string: cat.url) else {
                return
            }
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, _, _ in
                guard let data = data else {
                    return
                }
                
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.heightConstraint.constant = CGFloat(cat.height)
                    self.widthConstraint.constant = CGFloat(cat.width)
                    self.imageView.image = image
                }
            }.resume()
        })
        task.resume()
    }

}
