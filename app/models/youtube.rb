class Youtube
  attr_accessor :youtube_id
  attr_accessor :id

  @@client = YouTubeIt::Client.new(dev_key: ENV['YOUTUBE_KEY'])

  def initialize(youtube_id)
    @youtube_id = youtube_id
    @id = youtube_id
  end

  def self.videos_by(args)
    @@client.videos_by(args)
  end

  def html
    "<div class=\"youtube\"><iframe class=\"\" id=\"\" type=\"text/html\" width=\"425\" height=\"350\" src=\"http://www.youtube.com/embed/#{id}\" frameborder=\"0\"></iframe></div>\n"
  end

  def name
    'youtube'
  end
end
