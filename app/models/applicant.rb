class Applicant < ApplicationRecord
  belongs_to :client_detail, foreign_key: true, optional: true
  has_one :address, foreign_key: "home_address_id"
end
