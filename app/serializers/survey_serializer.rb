class SurveySerializer < ActiveModel::Serializer
  attributes :name, :all_information

  belongs_to :user

  def all_information
    object.all_questions
  end
end
