Geocoder.configure(
  # Google Maps API を使用
  lookup: :google,
  
  # Google Maps API キーを環境変数から取得
  api_key: ENV['GOOGLE_MAP_API_KEY'],
  
  # HTTPS 通信を使用
  use_https: true,
  
  # タイムアウト（秒）
  timeout: 5,
  
  # 緯度・経度の単位 (km or miles)
  units: :km,
  
  # レスポンスの言語設定を日本語に
  language: :ja
)