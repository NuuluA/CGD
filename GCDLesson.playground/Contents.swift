import UIKit
import PlaygroundSupport

class FirstViewController: UIViewController {
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VC-1"
        view.backgroundColor = .white
        
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    @objc func pressButton() {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initButton()
    }
    
    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Press", for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(button)
    }
}

class SecondViewController: UIViewController {
    
    var image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        loadImage()
    }
    
    func loadImage() {
        let imageURL: URL = URL(string: "https://www.closetag.com/images/photo4.jpg")!
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initImage()
    }
    
    func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        image.center = view.center
        image.layer.cornerRadius = 10
        view.addSubview(image)
    }
}

let vc = FirstViewController()
let navBar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navBar

