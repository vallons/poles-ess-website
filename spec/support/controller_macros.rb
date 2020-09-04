module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = FactoryBot.create(:admin)
      p admin.errors unless admin.valid?
      sign_in admin
    end
  end


end
