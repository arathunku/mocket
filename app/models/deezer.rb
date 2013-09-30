class Deezer
  attr_accessor :deezer_d
  attr_accessor :id

  # @@client =

  def initialize(deezer_d)
    @deezer_d = deezer_d
    @id = deezer_d
  end

  def self.get_id(name)
    response = Net::HTTP.get_response("api.deezer.com","/search?q=#{URI.escape(name)}")
    if response
      begin
        json = JSON.parse(response.body || '')
        json["data"].first["id"].to_s if json["total"].present? &&
          json["total"].to_i > 0
      rescue JSON::ParserError
        nil
      end
    else
      nil
    end
  end

  def html
    "<div class=\"deezer\"><iframe scrolling=\"no\" frameborder=\"0\" allowTransparency=\"true\" src=\"http://www.deezer.com/pl/plugins/player?autoplay=false&playlist=true&width=450&height=380&scover=true&type=tracks&id=#{id}&title=&app_id=undefined\" width=\"450\" height=\"380\"></iframe></div>\n"
  end

  def name
    'deezer'
  end
end
