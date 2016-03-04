class FiguresController < ApplicationController

  get '/figures' do
    @allfigs = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @fig = Figure.create(params["figure"])

    if !params["title"]["name"].empty?
      @fig.titles << Title.create(name: params["title"]["name"])
      @fig.save
    end

    if !params["landmark"]["name"].empty?
      @fig.landmarks << Landmark.create(name: params["landmark"]["name"])
      @fig.save
    end
    erb :'figures/show'
  end

  get '/figures/:id' do
    @fig = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @fig=Figure.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
   
    @fig=Figure.find(params[:id])

    if params["figure"]["name"].empty?
      params["figure"]["name"]=@fig.name
    end

    if !params["figure"]["title_ids"]
      params["figure"]["title_ids"]=[]
    end

    if !params["new_title"].empty?
      nt=Title.find_or_create_by(name: params["new_title"])
      params["figure"]["title_ids"] << nt.id
    end

    if !params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"]=[]
    end

    if !params["new_landmark"].empty?
      nlm=Landmark.find_or_create_by(name: params["new_landmark"])
      params["figure"]["landmark_ids"] << nlm.id
    end

    @fig.update(params["figure"])
    redirect "/figures/#{@fig.id}"
  end

end