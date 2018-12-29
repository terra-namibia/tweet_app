require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TweetApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Rails.cacheをRedisにする
    # config.cache_store = :redis_store, {
    #   host: "localhost",  # Redisサーバーのホスト名
    #   port: 6379,         # Redisサーバーのポート
    #   db: 0               # 保存するデータベース 0 ~ 15の任意
    # },{
    #   expires_in: 90.minutes # 保存期間
    # }

    # page cachingの保存先
    # config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/page_cache"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
