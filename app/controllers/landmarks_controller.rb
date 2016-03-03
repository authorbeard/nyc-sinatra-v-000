=begin

  allows you to view form to create a new landmark (FAILED - 10)
  allows you to create a new landmark (FAILED - 11)
  allows you to list all landmarks (FAILED - 12)
  allows you to see a single landmark (FAILED - 13)
  allows you to view form edit a single landmark (FAILED - 14)
  allows you to edit a single landmark (FAILED - 15)

=end




class LandmarksController < ApplicationController
  
  get '/landmarks' do
    @nyc=Landmark.all
    erb :'landmarks/index'
  end

end
