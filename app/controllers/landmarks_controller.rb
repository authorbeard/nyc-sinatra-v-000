class LandmarksController < ApplicationController
  
  get '/landmarks' do
    @nyc=Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do

    @ldmk = Landmark.create(params["landmark"])
    
    if params["figure"]["name"]
      @ldmk.figure=Figure.find_or_create_by(name: params["figure"]["name"])
    end
    
    @ldmk.save
    redirect '/landmarks'
  end

  get '/landmarks/:id' do
    @ldmk = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @ldmk=Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
   
    @ldmk=Landmark.find(params[:id])

    if params["landmark"]["name"].empty?
      params["landmark"]["name"]=@ldmk.name
    end

    if !params["new_figure"].empty?
      params["figure"]["figure_id"] = Figure.find_or_create_by(name: params["new_figure"]).id
    end

    @ldmk.update(params["landmark"])
    redirect "/landmarks/#{@ldmk.id}"
  end


end
