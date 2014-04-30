class MemStore
  _store = {}

  ###*
    メモリ状に入れておく
  ###
  constructor:()->


  @get:(key)->
    #store に格納されていなければ null を返す
    unless _store.hasOwnProperty key
      return null
    return _store[key]

  ###*
    ストアに value をセットする。
    既に指定された key の値が存在していた場合は上書きされる
  ###
  @set:(key, value)->
    _store[key] = value
    return


  ###*
    ストアに key が存在しなかった場合のみセットする
  ###
  @default:(key,value)->
    if _store.hasOwnProperty key
      return null

    _store[key] = value
    return


  ###*
    ストアから削除する
  ###
  @del:(key)->
    unless _store.hasOwnProperty key
      return null
    delete _store[key]
    return

