class CrimeApplication < ApplicationRecord

  attr_readonly :id
  enum status: Types::ApplicationStatus.mapping
  enum review_status: Types::ReviewApplicationStatus.mapping

  before_validation :shift_payload_attributes, on: [ :create, :update ]
  before_validation :set_overall_offence_class, on: [ :create, :update ]

  private

  def shift_payload_attributes
    return unless id.nil?
    return unless submitted_application

    self.id = submitted_application.fetch('id')
    self.submitted_at = submitted_application.fetch('submitted_at')
  end

  def set_overall_offence_class
    return unless submitted_application

    self.offence_class = Utils::OffenceClassCalculator.new(
      offences: submitted_application['case_details']['offences']
    ).offence_class
  end
end
