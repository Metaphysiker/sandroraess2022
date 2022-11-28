class VeganuaryItem < ApplicationRecord
  has_one_attached :company_logo

  has_many_attached :offer_images

end
