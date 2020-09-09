require "dry/container"
require "dry/transaction"
require "dry/transaction/operation"

class Container
  extend Dry::Container::Mixin

  namespace "surveys" do
    namespace "create" do
      register("validate")        { Surveys::Create::Validate.new }
      register("get_user")        { Surveys::Create::GetUser.new }
      register("create_survey")   { Surveys::Create::CreateSurvey.new }
    end
  end

  namespace "questions" do
    namespace "create" do
      register("validate")          { Questions::Create::Validate.new }
      register("create_question")   { Questions::Create::CreateQuestion.new }
    end
  end

  namespace "questions_options" do
    namespace "create" do
      register("validate")          { Options::Create::Validate.new }
      register("create_option")     { Options::Create::CreateOption.new }
    end
  end
end
