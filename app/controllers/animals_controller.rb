class AnimalsController < ApplicationController

	attr_reader :animal
  def show
  	@animal = Animal.find(params[:id])
  end
end

end
