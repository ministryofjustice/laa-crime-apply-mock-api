class InterestsOfJustice < ApplicationRecord
  belongs_to :maat_application, foreign_key: true, optional: true
end
