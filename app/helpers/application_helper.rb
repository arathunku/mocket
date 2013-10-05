module ApplicationHelper

  def active?(*symbol)
    symbol.any? do |s|
      params[:action] == s.to_s
    end
  end
end
