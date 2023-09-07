class MaatApplication < ApplicationRecord
  has_one :case_detail
  has_one :provider_detail
  has_one :client_detail
  has_many :interests_of_justices

  accepts_nested_attributes_for :provider_detail
  # json_schema = get_schema

  # validates :title, presence: true
  # validates :properties, presence: true, json: { schemas: :json_schema }
  # #
  #
  # def get_schema
  #   schema_file = File.open("app/assets/schemas/maat_application.json")
  #   file_data = schema_file.read
  #   schema_file.close
  #
  #   return file_data
  # end
end
