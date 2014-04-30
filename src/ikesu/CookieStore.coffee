class CookieStore
  prefix = "sake"
  _store = SimpleCookie

  ###*
    メモリ状に入れておく
  ###
  constructor:()->


  @get:(key)->
    #store に格納されていなければ null を返す
    val = _store.get key
    unless val
      return null
    return val

  ###*
    ストアに value をセットする。
    既に指定された key の値が存在していた場合は上書きされる
  ###
  @set:(key, value)->
    _store.set key, JSON.stringify(value)
    return


  ###*
    ストアに key が存在しなかった場合のみセットする
  ###
  @default:(key,value)->
    if _store.get key
      return null

    _store.set key, val
    return


  ###*
    ストアから削除する
  ###
  @del:(key)->
    val = _store.get key
    unless val
      return null
    _store.del key
    return


  @setStore:(store)->
    _store = store