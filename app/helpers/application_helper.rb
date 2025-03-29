module ApplicationHelper
  def default_meta_tags
      {
        title: "MRのための顧客管理システム", # デフォルトのタイトル
        reverse: true, # サイト名をタイトルの後に表示（例: "Welcome to Clinico | Clinico for MR"）
        description: "ClinicoはMRのためのシンプルな顧客管理システムです。", # サイトの説明
        keywords: "クリニック, 医院, 営業, MR, 顧客管理", # キーワード（SEO用）
        canonical: "https://mina.fly.dev", # カノニカルURL
        noindex: !Rails.env.production?, # 本番環境以外では検索エンジンにインデックスさせない
        twitter: {
          card: "summary_large_image" # Twitterカードの種類
        },
        og: {
          title: "Clinico for MR", # OGPタイトル
          description: "ClinicoはMRのためのシンプルな顧客管理システムです。", # OGP説明
          type: "website", # OGPのタイプ（例：website、articleなど）
          url: "https://mina.fly.dev", # OGP URL
          image: image_url("clinico.jpg") # OGP画像
        }
      }
  end
end
