# PythonBook
「Pythonと実データで遊んで学ぶ データ分析講座」 サポートページ

https://www.amazon.co.jp/dp/4863542836


# 書籍修正点
## 2019.12.03更新
* 3章で使用している、国土交通省のAPIですが、URLが変更されました。以下のように、「http://」となっているURLを「https://」と変更してください。
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
