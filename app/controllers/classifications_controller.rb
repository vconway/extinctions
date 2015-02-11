class ClassificationsController < ApplicationController

def index
@classifications = Classification.all
end

def show
@classifications = Classification.find(params[:id])
end


end

