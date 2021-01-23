class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.find_or_create_by(name: params[:pet][:name])
    # binding.pry
    if params[:pet][:owner_id]
      @pet.owner = Owner.find(params[:pet][:owner_id])
    elsif params[:pet][:owner_name] != ""
      @pet.owner = Owner.create(name: params[:pet][:owner_name])
    end
    @pet.save
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find params[:id]
    @owners = Owner.all
    # binding.pry
    erb :'/pets/edit'
  end
  patch '/pets/:id' do 
    @pet = Pet.find params[:id]
    @pet.name = params[:pet_name]
    
    if params[:owner][:name] != ""
      @pet.owner = Owner.create(name: params[:owner][:name])
    elsif params[:pet][:owner_id]
      @pet.owner = Owner.find(params[:pet][:owner_id])
    end
    # binding.pry
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end