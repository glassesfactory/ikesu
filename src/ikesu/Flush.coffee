class Flush

  ###*
    一度取得したらメッセージが消える Flush ストレージ
    アラートとか、非同期で遷移していくわけではないので一度しか使わなそうなものはここに入れるとよいかと。
    シングルトンなシングルトンなクラスからしか拾わないようなデータをやりとりするのに向いている。
    @class Flush
  ###
  _store = {}

  ###*
    メッセージを取得する。
    メッセージ取得後、内容は破棄される。
    @method get
    @static
    @param key {String} メッセージのキー
    @return {Object} メッセージ
  ###
  @get:(key)->
    val = _store[key]
    delete _store[key]
    return val

  ###*
    メッセージをセットする
    @method set
    @static
    @param key {String} メッセージのキー
    @param value {Object} メッセージ
  ###
  @set:(key, value)->
    _store[key] = value
    return