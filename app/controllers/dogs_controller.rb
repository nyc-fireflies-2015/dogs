get '/dogs' do
  @dogs = Dog.all
  erb :'dogs/index'
end

get '/dogs/name/:name' do
  @dog = Dog.find_by(name: params[:name])
  @dog.breed
end

get '/dogs/new' do
  @dog = Dog.new
  erb :'dogs/new'
end

get '/dogs/:id' do
  @dog = Dog.find(params[:id])
  @dog.name
end

post '/dogs' do
  dog = Dog.new(breed: params[:breed], name: params[:name])
  if dog.save
    redirect "/dogs/#{dog.id}"
  else
    "unsuccessful"
  end
end
