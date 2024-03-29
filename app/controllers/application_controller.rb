class ApplicationController < ActionController::Base
  before_action :clean_up_recipes
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :age, :sex, :height, :weight, :activity, :goal, :current_password])
  end

  private

  def clean_up_recipes
    CleanUpRecipesJob.perform_later
  end
end
