get '/dogs' do
  @dogs = Dog.all
  erb :'dogs/index'
end

get '/dogs/new' do
  erb :'dogs/new'
end

post '/dogs' do
  new_dog = Dog.create(params[:dog])
  if request.xhr?
    erb :'dogs/_dog', layout: false, locals: { dog: new_dog }
  else
    redirect "/dogs/#{new_dog.id}"
  end
end

get '/dogs/:id' do
  @dog = Dog.find(params[:id])
  erb :'dogs/show'
end

get '/demo' do
  erb :demo
end

get '/opt' do
  j =  erb :'dogs/_dog', layout: false, locals: { dog: Dog.first }
  {
    status: true,
    body: j
  }.to_json
end

patch '/dogs/:id' do
  (dog = Dog.find(params[:id]).increment(:likes)).save
  erb :'dogs/_dog', layout: false, locals: { dog: dog }
end
