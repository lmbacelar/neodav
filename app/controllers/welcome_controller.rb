class WelcomeController < ApplicationController
  def home
    authorize :welcome, :home?
  end
end
