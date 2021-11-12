# PythonBook
「Pythonと実データで遊んで学ぶ データ分析講座」 サポートページ

https://www.amazon.co.jp/dp/4863542836


# 書籍修正点
## 2019.12.03更新
* Chapter3 で使用している、国土交通省のAPIですが、URLが変更されました。以下のように、「http://」となっているURLを「https://」と変更してください。
  * 第2版では修正済みです。

## 2020.06.25更新
* Google Colaboratory 上でデフォルトで使用されている、 scikit-learn ライブラリのバージョンが変更されました
* それに伴い、いくつかの処理で、書籍中で紹介しているものと異なる結果になる可能性があります
* 現時点で判明したものを以下にまとめます（随時追加します）

### P134以降で登場する LogisticRegression
* デフォルトで使用される、ソルバーが変更されました
  * 公式サイト https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html
  * ソルバーとは各パラメータを求めるための、最適化アルゴリズムを指します
* 以下のように、solverに `liblinear` を指定すると、書籍中の結果と一致します

```python
logit = LogisticRegression(solver='liblinear')
```

* なお、本修正は 第3版では修正済みです。


## 2021.11.11更新

* Chapter6 P200のRMSE計算について、結果は変わっていませんが、計算順序が定義と異なっているため、以下に修正をお願いいたします。

![texclip20211112141247](https://user-images.githubusercontent.com/43558230/141413796-3a7f8c98-0a31-41f7-baf9-92f177411418.png)


* Chapter P201の「評価指標としてRMEを採用した場合、さまざまな回帰モデルを比較し、その中でMAE値が最も小さいモデルが良い、と判断されます。」のRMEは「MAE」の誤りです。
* Chapter6 P201のMAE計算について、結果は変わっていませんが、計算順序が定義と異なっているため、以下に修正をお願いいたします。

![texclip20211112142108](https://user-images.githubusercontent.com/43558230/141414206-9f3fda8c-4352-4f6d-a80d-2101ceff8204.png)


