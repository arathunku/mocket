class Deezer
  attr_accessor :deezer_d
  attr_accessor :id

  # @@client =

  def initialize(deezer_d=nil)
    @deezer_d = deezer_d
    @id = deezer_d
  end

  def self.get_id(name)
    response = nil #Net::HTTP.get_response("api.deezer.com","/search?q=#{URI.escape(name)}&access_token=#{ENV['DEEZER_ACCESS']}")
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

  def self.get_information(id)
    response = Net::HTTP.get_response("api.deezer.com","/track/{id}")
    if response
      begin
        json = JSON.parse(response.body || '')
        json["error"] ? nil : json.title
      rescue JSON::ParserError
        nil
      rescue
        nil
      end
    else
      nil
    end
  end

  def link
    if id
      "http://www.deezer.com/pl/plugins/player?autoplay=false&playlist=true&width=450&height=380&scover=true&type=tracks&id=#{id}&title=&app_id=#{ENV['DEEZER_ID']}"
    else
      nil
    end
  end

  def html
    "<div class=\"deezer\"><iframe scrolling=\"no\" frameborder=\"0\" allowTransparency=\"true\" src=\"#{link}\" width=\"450\" height=\"380\"></iframe></div>\n"
  end

  def name
    'deezer'
  end

end
