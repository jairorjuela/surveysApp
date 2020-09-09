class SurveySerializer < ActiveModel::Serializer
  attributes :name, :id

  belongs_to :user
end
