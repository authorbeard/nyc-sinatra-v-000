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
# binding.pry
    if !params["new_landmark"].empty?
      nlm=Landmark.create(name: params["new_landmark"])
      params["figure"]["landmark_ids"]<<nlm.id
    end
binding.pry

    if !params["new_title"].empty?
      nt=Title.create(name: params["new_title"])
      params["figure"]["title_ids"]<<nt.id
    end
binding.pry

    @fig.update(params["figure"])
    redirect "/figures/#{@fig.id}"
  end

end