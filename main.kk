import btree

fun test-query()
  val docs =
    [
      "o rato roeu a roupa do rei de roma",
      "O rei de roma vestiu sua roupa roida",
      "ele vestiu a roupa de seu amante rato",
    ]
  val dict = docs.map-indexed(fn(i, x) (i,x)).into_dict()

  val cases =
    [
      ("rei de roma", [0,1]),
      ("rato", [0,2]),
      ("vestiu a roupa", [1,2]),
    ]
  cases.map(fn((q, expected))
    val result = dict.query(q)
    result == expected
  )

fun into_dict(docs: list<(int, string)>)
  docs.flatmap fn((id, txt))
    txt.tokenize_simple.map fn(token)
      Node(token, [id], Empty, Empty)
  .foldl1(merge)

fun query(dict: btree, q: string)
  q.tokenize_simple.map(fn(x) dict.get(x)).foldl1(union)

fun union(a: list<int>, b: list<int>)
  match (a,b)
    (Cons(x,xs), Cons(y,ys)) ->
      if x > y then
        union([x] ++ xs, ys)
      elif x < y then
        union(xs, [y] ++ ys)
      else [x] ++ union(xs, ys)
    _ -> []

fun tokenize_simple(doc: string): list<string>
  val stop_words =
    ["o", "O", "do", "a", "A", "de", "seu", "sua"]
  doc.split(" ").remove fn(x) { stop_words.contains(x) }

fun contains(xs: list<string>, y: string): bool
  match xs
    Cons(x, xx) -> if x == y then True else contains(xx, y)
    Nil -> False
