type btree
  Node {
    key: string
    value: list<int>
    right: btree
    left: btree
  }
  Empty

fun show(a: btree)
  match a
    Node(key, value, right, left) ->
      "key: " ++ key ++ " " ++
      "value: " ++ value.map(show).join(",") ++ " " ++
      "right: (" ++ right.show ++ ") " ++
      "left: (" ++ left.show ++ ") "
    Empty -> "Empty"

fun insert(a: btree, target_key: string, target_value: list<int>)
  match a
    Node(key, value, right, left)  ->
      if key > target_key then
        Node(key, value, insert(right, target_key, target_value), left)
      elif key < target_key then
        Node(key, value, right, insert(left, target_key, target_value))
      else
        Node(key, value ++ target_value, right, left)
    Empty -> Node(target_key, target_value, Empty, Empty)

fun merge(a: btree, b: btree)
  match b
    Node(key, value, _) -> a.insert(key, value)
    Empty -> a

fun list(a: btree)
  match a
    Node(key, value, left, right) ->
     left.list() ++ [(key, value)] ++ right.list()
    Empty -> []

fun get(a: btree, target_key: string)
  match a
    Node(key, value, left, right) ->
      if key > target_key then
        get(left, target_key)
      elif key < target_key then
        get(right, target_key)
      else value
    Empty -> []
