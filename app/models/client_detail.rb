class ClientDetail < ApplicationRecord
  belongs_to :maat_application, foreign_key: true, optional: true
  has_one :applicant

  accepts_nested_attributes_for :applicant
end
