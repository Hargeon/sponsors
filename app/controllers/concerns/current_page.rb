module CurrentPage
  extend ActiveSupport::Concern

  MINIMUM_ENTRIES = 10

  included do
    rescue_from Pagy::OverflowError, with: :redirect_to_last_page
  end

  def from_entry(page)
    page.to_i < 2 ? 0 : (page.to_i - 1) * MINIMUM_ENTRIES
  end

  def redirect_to_last_page(exception)
    redirect_to root_path
  end
end
