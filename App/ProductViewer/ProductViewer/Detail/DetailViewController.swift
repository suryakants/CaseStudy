import UIKit
import Tempo

class ProductDetailViewController: UIViewController {
    
    var productItem: ListItemViewState?
    
    private let productImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.image = #imageLiteral(resourceName: "4")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: FontSizeConstants.title)
        label.textColor = UIColor.primaryFontColor
        label.textAlignment = .left
        return label
    }()
        
    private let descriptionLabel : UITextView = {
        
        let tv = UITextView()
        tv.textAlignment = .left
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: FontSizeConstants.detail)
        tv.textColor = UIColor.primaryFontColor
        tv.isEditable = false
        return tv
    }()
    
    private let addToCartButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Add to Cart", for: .normal)
        btn.setTitleColor(.primaryTitleFontColor, for: .normal)
        btn.backgroundColor = .primaryButtonBackgroudColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5.0
        return btn
    }()

    private let addToFavButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Add to List", for: .normal)
        btn.setTitleColor(.secondaryTitleFontColor, for: .normal)
        btn.backgroundColor = .secondaryButtonBackgroudColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5.0
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setValues()
        //locking up the orientation
        AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }

    private func setupView(){
        self.view.backgroundColor = .viewBackgroundColor
        self.view.addSubview(self.productImageView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.addToCartButton)
        self.view.addSubview(self.addToFavButton)
        
        self.addToFavButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: DetailViewConstant.favButtonPadding, size: DetailViewConstant.buttonSize)
        self.addToCartButton.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.addToFavButton.topAnchor, trailing: self.view.trailingAnchor, padding: DetailViewConstant.buttonPadding, size: DetailViewConstant.buttonSize)
        
        self.descriptionLabel.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.addToCartButton.topAnchor, trailing: self.view.trailingAnchor, padding: DetailViewConstant.buttonPadding, size: DetailViewConstant.descritptionViewSize)
        self.titleLabel.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.descriptionLabel.topAnchor, trailing: self.view.trailingAnchor, padding: DetailViewConstant.buttonPadding)
        
        self.productImageView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, padding: DetailViewConstant.buttonPadding)
    }
    
    private func setValues() {
        self.titleLabel.text = productItem?.priceStr
        self.descriptionLabel.text = productItem?.description
        if let imageUrl = productItem?.imageUrl {
            self.productImageView.loadImage(placeHolder: nil, urlString: imageUrl, completion: nil)
        }
    }
}
