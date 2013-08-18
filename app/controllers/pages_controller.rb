class PagesController < HighVoltage::PagesController
  #before_filter :authenticate
  layout :layout_for_page

  protected
    def layout_for_page
      case params[:id]
      when '//'
        '//'
      else
        'application'
      end
  end
end