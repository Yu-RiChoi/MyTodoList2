//
//  HomeViewController.swift
//  MyTodoList2
//
//  Created by 최유리 on 1/12/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://spartacodingclub.kr/css/images/scc-og.jpg"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error {
                print("에러 발생!!!")
                return
            }
            
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.imageView.image = image
            }
        })
        
        task.resume()
    }

}
