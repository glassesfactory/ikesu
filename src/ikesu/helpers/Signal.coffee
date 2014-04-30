###
  シグナル
###


class Signal
  @subscriber: {}

  ###*
    シグナルを送信する
    @method notify
    @static
    @param {String} signal 送信したいシグナル文字列
    @param args {Array} なんか引数混ぜる
  ###
  @notify:(signal, args)->
    cbs = Signal.subscriber[signal]
    if cbs
      cb(signal, args) for cb in cbs
    return


  ###*
    シグナルの通知を待ち受ける
    @method subscribe
    @static
    @param {String} signal 受信を待ち受けたいシグナル
    @param {Function} callback 受信した時に実行したい処理
  ###
  @subscribe:(signal, callback)->
    if not Signal.subscriber[signal]?
      Signal.subscriber[signal] = []
    Signal.subscriber[signal].push callback
    return


  ###*
    受信待受を解除する
    @method unsubscribe
    @static
    @param {String} signal 受信を解除したいシグナル
    @param {Function} callback 受信を解除したい処理
  ###
  @unsubscribe:(signal, callback)->
    #signal がそもそも登録されてなかった場合は返す
    unless Signal.subscriber.hasOwnProperty signal
      return

    i = 0
    arr = Signal.subscriber[signal]
    len = arr.length
    while i < len
      cb = arr[i]
      if cb is callback
        #0になる時はシグナルごと削除する
        if len is 1 then delete Signal.subscriber[signal] else arr.splice(i,1)
        break
      i++
    return

