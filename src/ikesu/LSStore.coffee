key    = null
_store = null
#ls 用 key のセットアップ
do ->
  ls_key = "ikesu"

  #store を取得しておく
  _store = JSON.parse(localStorege.getItem(ls_key))

  #ストアがなかったらからの dict を作って入れておく
  unless _store
    _store = {}
    localStorege.setItem ls_key, JSON.stringify(_store)
  return


class LSStore


  ###*
    LocalStorage に入れておく
    @class LSStore
  ###
  constructor:()->


  ###*
    ストアから値を取得する
    @method get
    @static
    @param key {String} 値が格納されているキー
  ###
  @get:(key)->
    #store に格納されていなければ null を返す
    unless _store.hasOwnProperty key
      return null
    return _store[key]


  ###*
    ストアに value をセットする。
    既に指定された key の値が存在していた場合は上書きされる
    @method set
    @static
    @param key {String} 値を格納するときのキー
    @param value {Object} 格納する値
  ###
  @set:(key, value)->
    _store[key] = value
    localStorage.setItem(ls_key, JSON.stringify(_store))
    return {
      key : value
    }


  ###*
    ストアに key が存在しなかった場合のみセットする
    @method default
    @static
    @param key {String} 格納するキー
    @param value {Object} 格納したい値
    @return 結果
  ###
  @default:(key, value)->
    if _store.hasOwnProperty key
      return null

    _store[key] = value
    return {
      key : value
    }


  ###*
    ストアからキーに該当する値を削除する
    @method del
    @static
    @param key {String} 削除したいキー
  ###
  @del:(key)->
    unless _store.hasOwnProperty key
      return null
    delete _store[key]
    return

