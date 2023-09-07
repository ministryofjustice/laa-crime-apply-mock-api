class Manager
  def create_new_application(params, permitted_fields)
    ActiveRecord::Base.transaction do
      @maat_application = MaatApplication.new(maat_application_params(params, permitted_fields[:maat_application]))
      @maat_application.save
      @provider_detail = @maat_application.create_provider_detail!(params.require(:provider_details).permit(permitted_fields[:provider_details]))
      @client_detail = @maat_application.create_client_detail!()
      @home_address = Address.new(params.require(:client_details).require(:applicant).require(:home_address).permit(permitted_fields[:home_address]))
      @home_address.save
      @correspondence_address = Address.new(params.require(:client_details).require(:applicant).require(:correspondence_address).permit(permitted_fields[:correspondence_address]))
      @correspondence_address.save
      @client_detail.create_applicant!(params.require(:client_details).require(:applicant).permit(permitted_fields[:applicant]))
      @client_detail.save
      @client_detail.applicant.home_address_id = @home_address.id
      @client_detail.applicant.correspondence_address_id = @correspondence_address.id
      @client_detail.applicant.save
      @case_detail = @maat_application.create_case_detail!(params.require(:case_details).permit(permitted_fields[:case_details]))
      params[:interests_of_justice].each do |ioj|
        @maat_application.interests_of_justices.create("ioj_type": ioj["type"], "reason": ioj["reason"])
        @maat_application.save
      end

      @maat_application.save
    end
  end

  def update_existing_application(maat_application, params, permitted_fields)
    ActiveRecord::Base.transaction do
      maat_application.update(maat_application_params(params, permitted_fields[:maat_application]))
      @provider_detail = maat_application.provider_detail.update(params.require(:provider_details).permit(permitted_fields[:provider_details]))
      @home_address = Address.find(maat_application.client_detail.applicant.home_address_id)
      @home_address.update(params.require(:client_details).require(:applicant).require(:home_address).permit(permitted_fields[:home_address]))
      @home_address.save
      @correspondence_address = Address.find(maat_application.client_detail.applicant.correspondence_address_id)
      @correspondence_address.update(params.require(:client_details).require(:applicant).require(:correspondence_address).permit(permitted_fields[:correspondence_address]))
      @correspondence_address.save
      @applicant = maat_application.client_detail.applicant.update(params.require(:client_details).require(:applicant).permit(permitted_fields[:applicant]))
      @case_detail = maat_application.case_detail.update(params.require(:case_details).permit(permitted_fields[:case_details]))
      # Clear existing interests of justice, then add new ones
      maat_application.interests_of_justices.destroy_all
      params[:interests_of_justice].each do |ioj|
        maat_application.interests_of_justices.create("ioj_type": ioj["type"], "reason": ioj["reason"])
        maat_application.save
      end
    end
  end

  def maat_application_params(params, permitted)
    # We're adding an additional field for maat_id so we can keep the default auto-incrementing id field
    permitted.push(:maat_id)
    params.require(:maat_application).permit(permitted).merge(maat_id: params[:id])
  end
end
