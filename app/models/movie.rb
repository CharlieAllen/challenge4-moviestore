class Movie < ActiveRecord::Base
  has_many :purchases
  has_many :buyers, through: :purchases
  validates_presence_of :title, :release_year, :price, :description, :imdb_id, :poster_url, :video_url

  def poster
    return "http://ia.media-imdb.com/images/M/#{poster_url}"
  end

  def imdb
    return "http://www.imdb.com/title/#{imdb_id}/"
  end

  def embed_video_url
    return nil unless video_url.respond_to?(:split)
    return "//www.youtube.com/embed/#{video_url.split('v=')[1].split('&list')[0]}"
  end

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end
  end
end