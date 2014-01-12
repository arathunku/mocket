class Youtube
  attr_accessor :youtube_id, :id, :client

  @@client = YouTubeIt::Client.new(dev_key: ENV['YOUTUBE_KEY'])

  def initialize(youtube_id=nil)
    @youtube_id = youtube_id
    @id = youtube_id
  end


  def self.videos_by(args)
    client.videos_by(args)
  end

  def self.get_information(id="")
    result = client.video_by(id)
    result ? result.title : nil
  end

  def self.client
    @@client
  end

  def client
    self.client
  end

  def link
    id ? "https://www.youtube.com/embed/#{id}" : nil
  end

  def html
    "<div class=\"youtube\"><iframe class=\"\" id=\"\" type=\"text/html\" width=\"425\" height=\"350\" src=\"#{link}\" frameborder=\"0\"></iframe></div>\n"
  end

  def name
    'youtube'
  end
end
