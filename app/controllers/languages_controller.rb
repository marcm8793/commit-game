# In app/controllers/languages_controller.rb
class LanguagesController < ApplicationController
  def show
    language = Language.find(params[:id])
    render json: { image_url: language.image_url }
  end
end
