import UIKit
import PlaygroundSupport

class DispatchGroupTest {
    private let queueSerial = DispatchQueue(label: "The Swift Dev")
    private let group = DispatchGroup()
    
    func loadInfo() {
        queueSerial.async(group: group) {
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: group) {
            sleep(1)
            print("2")
        }
        
        group.notify(queue: .main) {
            print("Finish!!")
        }
    }
}

//let dispatchGroupTest = DispatchGroupTest()
//dispatchGroupTest.loadInfo()

//MARK: - Second Version

class DispatchGroupTest1 {
    private let queueConc = DispatchQueue(label: "The Swift Dev", attributes: .concurrent)
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        groupBlack.enter()
        queueConc.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        
        groupBlack.enter()
        queueConc.async {
            sleep(2)
            print("2")
            self.groupBlack.leave()
        }
        
        groupBlack.wait()
        print("Finish!")
        
        groupBlack.notify(queue: .main) {
            print("Finish All!!!")
        }
    }
}

//let dispatchGroupTest1 = DispatchGroupTest1()
//dispatchGroupTest1.loadInfo()

class Image: UIView {
    
    public var images = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        images.append(UIImageView(frame: CGRect(x: 350, y: 80, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 180, y: 80, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 350, y: 200, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 180, y: 200, width: 100, height: 100)))
        
        images.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 120, y: 0, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 0, y: 180, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 140, y: 230, width: 100, height: 100)))
        
        for i in 0...7 {
            images[i].contentMode = .scaleAspectFit
            self.addSubview(images[i])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let imageURL = ["https://www.closetag.com/images/photo4.jpg", "https://ichef.bbci.co.uk/news/999/cpsprodpb/15951/production/_117310488_16.jpg", "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", "https://media.istockphoto.com/photos/photo-depicting-the-person-who-focuses-on-the- -picture-id1249041775?b=1&k=20&m=1249041775&s=170667a&w=0&h=Pt6ltIPqpMrceX3FCtAEg69BjzrRJv4ZWh0n5rr3Uqs="]

var allImages = [UIImage]()

let view = Image(frame: CGRect(x: 0, y: 0, width: 600, height: 800))
view.backgroundColor = UIColor.red

func asyncLoadImage(imageURL: URL,
                    runQueue: DispatchQueue,
                    completionQueue: DispatchQueue,
                    completion: @escaping(UIImage?, Error?)-> ()) {
    runQueue.async {
        
        do {
            let data = try Data(contentsOf: imageURL)
            completionQueue.async {
                completion(UIImage(data: data), nil)
            }
        } catch let error {
            completion(nil, error)
        }
    }
}

func asyncGroup() {
    let group = DispatchGroup()
    
    for i in 0...3 {
        group.enter()
        
        asyncLoadImage(imageURL: URL(string: imageURL[i])!,
                       runQueue: .global(),
                       completionQueue: .main) { image, error in
            guard let image1 = image else { return }
            allImages.append(image1)
            
            group.leave()
        }
    }
    
    group.notify(queue: .main) {
        for i in 0...3 {
            view.images[i].image = allImages[i]
        }
    }
}

func asyncURLSession() {
    for i in 0...4 {
        guard let url = URL(string: imageURL[i]) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, resoinse, error in
            DispatchQueue.main.async {
                view.images[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

//asyncURLSession()

//asyncGroup()

PlaygroundPage.current.liveView = view

