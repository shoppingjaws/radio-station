variable "service" {
  type    = string
  default = "radio_station"
}

variable "bucket_name" {
  type        = string
  default     = "radio-station-shoppingjaws"
  description = "s3 bucket name. replace it."
}

variable "channels" {
  type = list(object({
    title          = string
    id             = string
    area           = string
    station        = string
    exec_time_hour = number
    exec_time_min  = number
    exec_dayweek   = string
    rec_time_hour  = number
    rec_time_min   = number
    rec_dayweek    = string
    image          = string
  }))
  default = [{
    title          = "オードリーのオールナイトニッポン"
    id             = "audrey"
    area           = "JP13"
    station        = "LFR"
    exec_dayweek   = "SUN"
    exec_time_min  = 0
    exec_time_hour = 4
    image          = "https://radiko.jp/res/program/DEFAULT_IMAGE/IBS/i03z6mzyq4.jpg"
    rec_dayweek    = "SUN"
    rec_time_min   = 0
    rec_time_hour  = 1
    }, {
    title          = "霜降り明星のオールナイトニッポン"
    id             = "shimofuri"
    area           = "JP13"
    station        = "LFR"
    exec_dayweek   = "SAT"
    exec_time_min  = 0
    exec_time_hour = 4
    image          = "https://i.scdn.co/image/ab6765630000ba8acbe64777258e8652af51a129"
    rec_dayweek    = "SAT"
    rec_time_min   = 0
    rec_time_hour  = 1
    }, {
    title          = "アルコ＆ピースD.C.GARAGE"
    id             = "dcg"
    area           = "JP13"
    station        = "TBS"
    exec_dayweek   = "WED"
    exec_time_min  = 0
    exec_time_hour = 3
    image          = "https://i.scdn.co/image/ab6765630000ba8aa55f94fad751e63c8f019834"
    rec_dayweek    = "WED"
    rec_time_min   = 0
    rec_time_hour  = 0
    }, {
    title          = "ハライチのターン"
    id             = "haraichi"
    area           = "JP13"
    station        = "TBS"
    exec_dayweek   = "FRI"
    exec_time_min  = 0
    exec_time_hour = 3
    image          = "https://i.scdn.co/image/ab67656300005f1fd89c4d7d72800b603937135f"
    rec_dayweek    = "FRI"
    rec_time_min   = 0
    rec_time_hour  = 0
    }, {
    title          = "有吉弘行のSUNDAY_NIGHT_DREAMER"
    id             = "snd"
    area           = "JP9"
    station        = "RADIOBERRY"
    exec_dayweek   = "SUN"
    exec_time_min  = 0
    exec_time_hour = 23
    image          = "https://park-cf.gsj.mobi/program/appimages/27400/672.jpg"
    rec_dayweek    = "SUN"
    rec_time_min   = 0
    rec_time_hour  = 20
    }, {
    title          = "佐久間宣行のオールナイトニッポン0"
    id             = "sakumazero"
    area           = "JP13"
    station        = "LFR"
    exec_dayweek   = "THU"
    exec_time_min  = 0
    exec_time_hour = 6
    image          = "https://i.scdn.co/image/ab6765630000ba8a01a2246aa686f72f2adeb40e"
    rec_dayweek    = "THU"
    rec_time_min   = 0
    rec_time_hour  = 3
    }, {
    title          = "おぎやはぎのメガネびいき"
    id             = "ogiyahagi"
    area           = "JP13"
    station        = "TBS"
    exec_dayweek   = "FRI"
    exec_time_min  = 0
    exec_time_hour = 4
    image          = "https://radiko.jp/res/program/DEFAULT_IMAGE/TBS/mgqwj57j5a.jpg"
    rec_dayweek    = "FRI"
    rec_time_min   = 0
    rec_time_hour  = 1
    },
    {
      title          = "山里亮太の不毛な議論"
      id             = "yamasato"
      area           = "JP13"
      station        = "TBS"
      exec_dayweek   = "THU"
      exec_time_min  = 0
      exec_time_hour = 4
      image          = "https://tbsradio.g.kuroco-img.app/v=1631433516/files/topics/44299_ext_04_0.jpg?width=1200"
      rec_dayweek    = "THU"
      rec_time_min   = 0
      rec_time_hour  = 1
      }, {
      title          = "三四郎のオールナイトニッポン0"
      id             = "sanshirozero"
      area           = "JP13"
      station        = "LFR"
      exec_dayweek   = "SAT"
      exec_time_min  = 0
      exec_time_hour = 6
      image          = "https://podcast.1242.com/wp-content/uploads/2020/03/thumb_annzero_sanshiro2022-e1649379852168.jpg"
      rec_dayweek    = "SAT"
      rec_time_min   = 0
      rec_time_hour  = 3
      },
      {
      title          = "ランジャタイによりますと"
      id             = "ranjatai"
      area           = "JP16"
      station        = "KNB"
      exec_dayweek   = "SUN"
      exec_time_min  = 0
      exec_time_hour = 23
      image          = "https://pbs.twimg.com/card_img/1879876163176407040/B5c-XxoE?format=jpg"
      rec_dayweek    = "SAT"
      rec_time_min   = 0
      rec_time_hour  = 22
      }]
}