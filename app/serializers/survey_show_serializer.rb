class SurveyShowSerializer < ActiveModel::Serializer
  attributes :survey, :owner, :created_questions, :created_options
end
