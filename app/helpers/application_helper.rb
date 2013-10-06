module ApplicationHelper

  def active?(*symbol)
    symbol.any? do |s|
      action_name == s.to_s || controller_name == s.to_s
    end
  end
end
