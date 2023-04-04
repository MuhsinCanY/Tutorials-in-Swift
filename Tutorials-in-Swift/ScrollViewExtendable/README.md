
# ScrollView Usage Programmatically




![ezgif com-video-to-gif](https://user-images.githubusercontent.com/96295315/229807342-3dbe0d92-bbdf-48d6-9ada-e9df524c6467.gif)


```swift
        view.backgroundColor = .systemRed
        
        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 10, width: view.bounds.width - 20, height: view.bounds.height - 20))
        scrollView.backgroundColor = .systemGreen
        view.addSubview(scrollView)
        
        let upperButton = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        upperButton.backgroundColor = .systemBlue
        scrollView.addSubview(upperButton)
        
        let lowerButton = UIButton(frame: CGRect(x: 20, y: 2000, width: 100, height: 100))
        lowerButton.backgroundColor = .systemBlue
        scrollView.addSubview(lowerButton)
        
        scrollView.contentSize = CGSize(width: view.frame.width - 20, height: 2200)
```
## Descriptions

Eng
After determining the frame in the Scroll View, the most important feature is "contentSize".
In the example, I designed a scroll that works vertically. If desired, it can be done horizontally by making changes in "contentSize".

Tr
Scroll View'de frame belirlendikten sonra en çok dikkat edilmesi gereken özellik "contentSize" dır.
Örnekte dikey olarak çalışan bir scroll tasarladım. "contentSize" da değişişlikler yaparak yatayda çalışma yapılabilir.



