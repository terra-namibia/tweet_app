class Post < ApplicationRecord

    validates :content, {presence: true, length: {maximum: 140}}
    validates :user_id, {presence: true}
    
    def user
      return User.find_by(id: self.user_id)
    end
    
    def abbreviated_content
      # 最大19文字まで表示
      content.size > 19 ? "#{content.slice(0, 19)}..." : content
    end
    
    # model cache
    def self.cache_all
      Rails.cache.fetch("posts"){Post.all}
    end
  
end
