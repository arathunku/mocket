module UserHelper

  def select_default_player(option)
    (current_user.default_player || 'youtube') == option
  end
end
