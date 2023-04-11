//
//  ViewController.swift
//  Tabbar
//
//  Created by Muhsin Can Yılmaz on 6.04.2023.
//

import UIKit

class ViewController: UITabBarController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let tabSymbols = ["house.fill", "heart.fill", "gearshape.fill"]
    
    lazy var tabCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let tabCollectionView = UICollectionView(frame: CGRect(x: 25, y: view.frame.height - 100, width: view.frame.width - 50, height: 50), collectionViewLayout: layout)
        
        tabCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tabCollectionView.showsHorizontalScrollIndicator = false
        tabCollectionView.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
        tabCollectionView.dataSource = self
        tabCollectionView.delegate = self
        
        tabCollectionView.backgroundColor = UIColor.init(white: 0.01, alpha: 0.9)
        tabCollectionView.layer.cornerRadius = 25
        
        return tabCollectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors: [UIColor] = [.red, .white, .blue]

        let  vcs = colors.map { color -> UIViewController in
            let vc = UIViewController()
            vc.view.backgroundColor = color
            return vc
        }

        viewControllers = vcs
        
        view.addSubview(tabCollectionView)
        tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tabSymbols.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as! TabCell
        cell.imageView.image = UIImage(systemName: tabSymbols[indexPath.item])?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (tabCollectionView.frame.width - 20) / 3, height: 50)
    }
    
}

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
        
        bottomView.layer.cornerRadius = 2
    }
    
    override var isHighlighted: Bool{
        didSet{
            let duration = 2
            let damping: CGFloat = 0.5
            let scale: CGFloat = 0.9
            
            UIView.animate(withDuration: TimeInterval(duration), delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: [], animations: {
                if self.isHighlighted {
                    self.imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
                    self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
                    self.imageView.tintColor = .white
                } else {
                    self.imageView.transform = .identity
                    self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
                }
            })
        }
    }
    
    
    override var isSelected: Bool {
        didSet {
            let duration = 2
            let damping: CGFloat = 0.5
            let scale: CGFloat = 1.2
            
            UIView.animate(withDuration: TimeInterval(duration), delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: [], animations: {
                if self.isSelected {
                    self.imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
                    self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
                    self.imageView.tintColor = .white
                    self.bottomView.backgroundColor = .white
                } else {
                    self.imageView.transform = .identity
                    self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
                    self.imageView.tintColor = .lightGray
                    self.bottomView.backgroundColor = .clear
                }
            })
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

