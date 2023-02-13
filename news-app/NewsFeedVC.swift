//
//  NewsFeedVC.swift
//  news-app
//
//  Created by Melih Cüneyter on 6.02.2023.
//

import UIKit
import WebKit

final class NewsFeedVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var parser = XMLParser()
    var newsDetail: [String] = []
    var newsArr: [[String]] = []
    var newsContent: String = ""
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Güncel Haberler"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchdata()
        
        collectionView.register(.init(nibName: "NewsCVC", bundle: nil), forCellWithReuseIdentifier: "NewsCVC")
    }
    
    // MARK: - Fetch Data With XMLParser
    func fetchdata() {
        let source = "https://www.cnnturk.com/feed/rss/all/news"
        let url = URL(string: source)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                print(self.newsArr)
            }
        }
        task.resume()
    }
}

// MARK: - XMLParser Delegate Methods
extension NewsFeedVC: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        newsArr.removeAll()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            newsDetail.removeAll()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        newsContent = string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "image" || elementName == "description" || elementName == "link" || elementName == "title" {
            newsDetail.append(newsContent)
        } else if elementName == "item" {
            newsArr.append(newsDetail)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView Datasource - Delegate
extension NewsFeedVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCVC", for: indexPath) as! NewsCVC
        let arrTemp = newsArr[indexPath.row]
        cell.configureCell(arr: arrTemp)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // go detailsVC
        let vc = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier:"NewsDisplayVC") as! NewsDisplayVC
        let arrTemp = newsArr[indexPath.row]
        vc.url = arrTemp[0]
        self.navigationController?.pushViewController(vc, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - CollectionView - FlowLayoutDelegate
extension NewsFeedVC: UICollectionViewDelegateFlowLayout {
    // TODO: - fix this style
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (collectionView.frame.width - 20) / 2, height: (collectionView.frame.height - 20) / 2) // 2 columns layout all phone display
    }
}
