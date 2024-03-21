//
//  HomeTableCell.swift
//  BeautyScan
//
//  Created by admin on 18.11.2023.
//

import UIKit
import SDWebImage

final class HomeTableCell: UITableViewCell {
    @IBOutlet private weak var brandNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var tableImageView: UIImageView!
    @IBOutlet private weak var learnMoreBtn: UIButton!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var backView: UIView!
    private var link: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO: addConstants
        backView.layer.cornerRadius = 10
    }
    
    func setup(product: Product, searchData: Item?) {
        configureLabels(for: product)
        configureImageView(with: product.cover)
        configureLearnMoreButton(with: searchData)
    }
    
    func setupForProduct(result: ProductSearch?) {
        configureLabelsForSearch(for: result)
        configureImageViewForSearch(with: result?.imageLink ?? "")
        configureLearnMoreButtonForSearch(with: result?.productLink ?? "")
    }
    
    private func configureLabelsForSearch(for product: ProductSearch?) {
        guard let price = product?.price, let roundedIntPrice = convertStringToRoundedInt(price) else {
            return
        }
        //TODO: addConstatnts
        priceLabel.text = convertToPrice(number: convertDollarsToRubles(dollarsAmount: roundedIntPrice, exchangeRate: 90))
        descriptionLabel.text = product?.name
        brandNameLabel.text = product?.brand
    }
    
    private func configureImageViewForSearch(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        tableImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func configureLearnMoreButtonForSearch(with searchData: String) {
        learnMoreBtn.isHidden = false
        link = searchData
    }
    
    private func configureLabels(for product: Product) {
        let price = convertToPrice(number: product.price.current ?? 0)
        priceLabel.text = price
        descriptionLabel.text = product.name
        brandNameLabel.text = product.brand.name
    }
    
    private func convertDollarsToRubles(dollarsAmount: Int, exchangeRate: Int) -> Int {
        let rublesAmount = dollarsAmount * exchangeRate
        return rublesAmount
    }
    
    private func convertToPrice(number: Int, prefix: String = "") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        
        let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) ?? ""
        
        let finalString = "\(prefix)\(formattedNumber) ₽"
        return finalString
    }
    
    private func configureImageView(with cover: Cover?) {
        guard let urlString = cover?.srcM, let url = URL(string: "\(AppConfig.domain)\(urlString)") else {
            return
        }
        tableImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func configureLearnMoreButton(with searchData: Item?) {
        if let searchData = searchData {
            learnMoreBtn.isHidden = false
            link = searchData.link
        } else {
            learnMoreBtn.isHidden = true
            link = nil
        }
    }
    
    
    @IBAction func learnMoreAction() {
        if let link = link {
            openLink(url: URL(string: link))
        }
    }
    
    //TODO: Place to BaseCell
    private func openLink(url: URL?) {
        let app = UIApplication.shared
        guard let url = url else { return }
        if app.canOpenURL(url) {
            app.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func convertStringToRoundedInt(_ stringValue: String) -> Int? {
        guard let floatValue = Float(stringValue) else {
            return nil
        }
        let roundedIntValue = Int(round(floatValue))
        return roundedIntValue
    }
}
