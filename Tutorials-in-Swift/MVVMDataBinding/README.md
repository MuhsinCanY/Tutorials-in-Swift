
# MVVM Data Binding

Data binding'in  3 farklı yöntemini açıklayacağım.


## Standart Binding

```swift
class ViewModel1{
    
    var data = [String]()
    
    func recieveData(){
        let array = ["Hello World 1", "Hello World 2", "Hello World 3", "Hello World 4", "Hello World 5",]
        data = array
    }
    
}
```

ViewModel'i oluşturduktan sonra ViewController'da bir ViewModel Nesnesi oluşturarak işlemlerimizi yapabiliriz.


```swift
class ViewController1: UIViewController {

    let viewModel = ViewModel1()
    var viewData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.recieveData()
        
        viewData = viewModel.data
    }

}
```

Burada ilk önce viewModel.recieveData() çağırmak önemlidir. Bu fonksiyonu çağırmazsak viewModel'deki data'ya istediğimiz değerler atanmayacaktır.
## Binding with Closure

```swift
class ViewModel2{
    
    var onDataReceived: (([String]) -> Void)?
    
    func recieveData(){
        let array = ["Hello World 1", "Hello World 2", "Hello World 3", "Hello World 4", "Hello World 5",]
        onDataReceived?(array)
    }
    
}
```

```swift
class ViewController2: UIViewController {
    
    let viewModel = ViewModel2()
    var viewData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onDataReceived = { [weak self] data in
            self?.viewData = data
        }
        
        viewModel.recieveData()
    }

}
```

Burada closure içinde viewModel'den gelen data ile yapmak istediğimiz işlemleri yapıyoruz.
Ayrıca Memory Leak'i engellemek için self'i weak yapıyoruz.

Yine sıraya önem vermemiz gerekiyor. Eğer viewModel'deki closure'ı tanımlamadan viewModel.recieveData() çağırırsak closure nil olduğu için birşey yapmamış olacağız.
## Data Binding with Observable

Bu metod ile reactive framework'lerin yapmış olduğu işlerin büyük çoğunluğunu yapmış olacağız

Öncekinden farklı olarak closure olusturmak yerine generic yapıda olan Observable class'ından nesne oluşturarak bağlama işlemini gerçekleştireceğiz.

```swift
class Observable<T>{
    
    var value: T?{
        didSet{
            _callback?(value)
        }
    }
    
    private var _callback: ((T?) -> Void)?
    
    func bind(_ callback: @escaping (T?) -> Void){
        _callback = callback
    }
    
}
```

```swift
class ViewModel3{
    
    var data: Observable<[String]> = Observable()
    
    func recieveData(){
        let array = ["Hello World 1", "Hello World 2", "Hello World 3", "Hello World 4", "Hello World 5",]
        data.value = array
    }
}
```

```swift
class ViewController3: UIViewController {
    
    var viewData = [String]()
    var viewModel = ViewModel3()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.data.bind { [weak self] data in
            self?.viewData = data ?? []
        }
        
        viewModel.recieveData()
    }


}
```
