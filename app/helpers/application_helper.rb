module ApplicationHelper

  def active?(symbol)
    params[:action] == symbol.to_s
  end
end
