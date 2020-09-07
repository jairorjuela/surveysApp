require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:user)    { create(:user, email: "holi@mail.com") }

  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "The survey values are valid" do
    it "Should create the user" do
      subject.name = "Soy un test"
      subject.user = user

      expect(subject).to be_valid
    end
  end

  describe "The survey values are not valid" do
    describe "the user not exist" do
      it "Should not create the user" do
        subject.name = "test"

        expect(subject).to be_invalid
        expect(subject.errors.messages[:user]).to match_array("Debe registrarse o ingresar a la plataforma") 
      end
    end
  end
end
