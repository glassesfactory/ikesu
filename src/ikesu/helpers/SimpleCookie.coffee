#cookie への参照をとっておく
cookie = document.cookie

#はこ
_dict  = {}


_getAllCookie = ()=>
  #箱を初期化する
  _dict = {}
  if cookie is ""
    return _dict
  cookies = cookie.split '; '
  for kv in cookies
    obj = kv.split('=')
    _dict[obj[0]] = decodeURIComponent obj[1]
  return


###*
  有効期限をとる
  expire_type の指定がなかったらデフォルトは 日
  @method _getExpire
  @private
###
_getExpire = (option)=>
  exipre = Number(option.expire)
  date = new Date()
  if not option.hasOwnProperty "expire_type" or option.expire_type is CookieExpireEnum.DAY
    date.setTime date.getTime() + 1000 * 3600 * 24 * expire
    expireStr = "expires=" + date.toUTCString()
    return expireStr

  expire_type = option.expire_type
  if expire_type is CookieExpireEnum.MINUTE
    timePrefix = 1000 * 60 * expire
  else if expire_type is CookieExpireEnum.HOUR
    timePrefix = 1000 * 3600 * expire
  else if expire_type is CookieExpireEnum.WEEK
    timePrefix = 1000 * 3600 * 24 * (7 * expire)
  else if expire_type is CookieExpireEnum.MONTH
    timePrefix = 1000 * 3600 * 24 * 30 * expires

  expireStr = "expires=" + date.toUTCString()
  return expireStr


SimpleCookie =

  ###*
    初期化処理を行う。
    ブラウザのクッキーから全部取り出して箱に格納する
    @metho init
  ###
  init:()=>
    _getAllCookie()
    return


  ###*
    取得する
    毎回パースしてると遅いので基本的にはメモリ上の dict から取ってくる。
    @method get
    @param key {String} クッキーを格納してあるキー
    @aram force {Boolean} 必ずブラウザのクッキー内から返すかどうか
    @return Object
  ###
  get:(key, force)->
    if force
      _getAllCookie()
    #箱に入ってたらすぐ返す
    if _dict.hasOwnProperty key
      return _dict[key]
    else
      return false


  ###*
    クッキーを書き込む
    @method set
    @param key {String} キー
    @param value {String}
    @param options {Object}
      ```
      {
        expire_type : "day", //minut, hour, day, week, month
        expire      : 2,
        path        : "/userpage",
        domain      : "example.com",
        secure      : true
      }
      ```
    @return Object 書き込んだオブジェクト
  ###
  set:(key, value, options)->
    _dict[key] = value

    data = String(key) + '=' + String(value)
    #オプションが指定されていなければ何も考えずにぶっこむ
    unless options
      document.cookie = data
      return do ->
        obj = {}
        obj[key] = value
        return obj

    #パスを含める
    if options.hasOwnProperty "path"
      data += "; " + "path=" + options.path
    #ドメインを含める
    if options.hasOwnProperty "domain"
      data += "; " + "domain=" + options.domain

    #有効期限
    if options.hasOwnProperty "expire"
      data += "; " + _getExpire options

    #SSL 環境下でのみ使える
    if options.hasOwnProperty "secure"
      data += "secure"

    document.cookie = data
    #クッキー突っ込まれたら通知とばす
    Signal.notify SignalEnum.COOKIE_UPDATE
    return do ->
      obj = {}
      obj[key] = value
      return obj


  ###*
    day の expire を入れる
    @method setWithDay
    @param key {String} キー
    @param value {Object} セットしたい何か
    @param day {Number} 日
    @param options {Object} その他のオプション
  ###
  setWithDay:(key, value, day=1, options={})=>
    options.expire_type = CookieExpireEnum.DAY
    options.expire = day
    result = SimpleCookie.set key, value, options
    return result


  ###*
    weej の expire を入れる
    @method setWithWeek
    @param key {String} キー
    @param value {Object} セットしたい何か
    @param week {Number} 週
    @param options {Object} その他のオプション
  ###
  setWithWeek:(key, value, week=1, options={})=>
    options.expire_type = CookieExpireEnum.WEEK
    options.expire = week
    result = SimpleCookie.set key, value, options
    return result


  ###*
    monath の expire を入れる
    @method setWithMonth
    @param key {String} キー
    @param value {Object} セットしたい何か
    @param month {Number} 月
    @param options {Object} その他のオプション
  ###
  setWithMonth:(key, value, month=1, options={})=>
    options.expire_type = CookieExpireEnum.MONTH
    options.expire = month
    result = SimpleCookie.set key, value, options
    return result


  ###*
    cookie を削除する
    @method del
    @param key {String} 削除したいキー
  ###
  del:(key)=>
    delete _dict[key]
    SimpleCookie.set key, ""
    return




do ->
  #
  SimpleCookie.init()