require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe "The user values are valid" do
    it "Should create the user" do
      subject.email = "batman@mail.com"
      subject.password = "baticave123"

      expect(subject).to be_valid
    end
  end

  describe "The user values are not valid" do
    describe "the email is invalid" do
      it "Should not create the user" do
        subject.password = "baticave123"
        subject.email = "badEmail*com"

        expect(subject).to be_invalid
        expect(subject.errors.messages[:email]).to match_array("El email es inválido") 
      end
    end

    describe "the password is too short" do
      it "Should not create the user" do
        subject.email = "bad@Email.com"
        subject.password = "1q2w3"

        expect(subject).to be_invalid
        expect(subject.errors.messages[:password]).to match_array(["La contraseña es muy corta, el mínimo son 6 caracteres"])
      end
    end

    describe "the email can not be blank" do
      it "Should not create the user" do
        subject.email = ""
        subject.password = "1q2w35"

        expect(subject).to be_invalid
        expect(subject.errors.messages[:email]).to match_array(["El email es inválido", "El email no puede estar vacio"])
      end
    end

    describe "the password can not be blank" do
      it "Should not create the user" do
        subject.email = "badEmail*com"
        subject.password = ""

        expect(subject).to be_invalid
        expect(subject.errors.messages[:password]).to match_array(["El campo de la contraseña no puede estar vacio"])
      end
    end
  end
end
