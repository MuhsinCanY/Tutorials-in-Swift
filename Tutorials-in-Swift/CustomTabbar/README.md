
# Custom Tabbar with UICollectionView

Burada UITabBarController sınıfının default tabbar'ını kullanmak yerine kendimiz CollectionView kullanarak bir tane oluşturacağız.

![ezgif com-video-to-gif](https://user-images.githubusercontent.com/96295315/231154918-597ff5a5-b4a3-41ff-be65-ea26f96d1c55.gif)


İlk önce ViewController'ı UITabBarController'ın subclass'ı yapıyoruz.

```swift
class ViewController: UITabBarController{
    ...
}
```
Sonra CollectionView'ı oluşturup ayarlamalarını yapıyoruz.


```swift
lazy var tabCollectionView: UICollectionView = {
        
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0

    let tabCollectionView = UICollectionView(frame: CGRect(x: 25, y: view.frame.height - 100, width: view.frame.width - 50, height: 50), collectionViewLayout: layout)
        
    tabCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    tabCollectionView.showsHorizontalScrollIndicator = false
    tabCollectionView.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")   
    tabCollectionView.backgroundColor = .black
    tabCollectionView.layer.cornerRadius = 25

    tabCollectionView.dataSource = self
    tabCollectionView.delegate = self

    return tabCollectionView
}()
```
## TabCell

Sonra CollectionViewCell'i isteğimize göre dizayn ediyoruz.

```swift
class TabCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let bottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        [imageView, bottomView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        bottomView.layer.cornerRadius = 3
    }
    
    //Buradakı animasyonlar yazının uzamaması için silinmiştir. İlgili dosyadan ulaşılabilir

    override var isHighlighted: Bool{
        ...
    }
    override var isSelected: Bool {
        ...
    }
}
```
## 

Sonrasında tabBar tıklandığında değişimi görebilmek için farklı renklerde ViewController oluşturalım.

Ayrıca default olan tabBar ile işimiz olmadığı için bunu gizliyoruz.Bunu yapmayınca ekranın altında tabBar'ın yerinde tıklama yaptığımızda ekran değişiyor.

```swift
    let colors: [UIColor] = [.red, .green, .blue]

    let  vcs = colors.map { color -> UIViewController in
        let vc = UIViewController()
        vc.view.backgroundColor = color
        return vc
    }

    viewControllers = vcs
        
    tabBar.isHidden = true
```
## 

Burada tabBar için icon ayarlaması yapıyoruz ve cell'i buna göre değiştiriyoruz.

```swift
    let tabSymbols = ["house.fill", "heart.fill", "gearshape.fill"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabSymbols.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as! TabCell
        cell.imageView.image = UIImage(systemName: tabSymbols[indexPath.item])?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (tabCollectionView.frame.width - 20) / 3, height: 50)
    }
```
## 

Son olarak uygulama açıldığında ilk tab'ı seçmek için aşağıdaki kodu ekliyoruz.

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        
    tabCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
 }
```
