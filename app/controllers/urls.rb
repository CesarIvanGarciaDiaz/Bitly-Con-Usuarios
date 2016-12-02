
get '/crear_url' do

  erb :index_url
end

# get '/test' do

# redirect to session[:ulr_final]
# end


get '/correcto' do
  if logged_in?
    user_logged = current_user
    @message = session[:message]
    @url_all = Url.where(user_id: user_logged.id) #current_user.urls
    p @url_all
    erb :new_url


  else
    @message = session[:message]
    @url_all = Url.where(user_id: nil)
    p @url_all
    erb :new_url
  end
end


post '/principal' do
  @new_url = params[:user_input]
  p "Estaos en principal"
  # p @new_url
  @validar = Url.new(user_id: session[:id] ,url_anterior: @new_url, click_count: 0)
  # p @validar
  # @validar.save

  if @validar.save
    session[:message] = "El registro fue salvado"
  else
    session[:message] = "error el registro no se salvo"
  end


  redirect to ('/correcto')
end

# e.g., /q6bda
get '/crear_url/:short_url' do
   # redirige a la URL original
  # @url_visitated
  user_input = params[:short_url]
  p user_input
  u = Url.find_by(url_nueva: user_input)
  u.update(click_count: u.click_count + 1)
  p "estes es el url anterior"
  p u.url_anterior
 # redirect to ("http://#{u.url_anterior}")
  if u.url_anterior.include?('http')
    redirect to ("#{u.url_anterior}")
  else
    redirect to ("http://#{u.url_anterior}")
  end

 # session[:ulr_final] = u.url_anterior
 # redirect to ('/test')

end


get '/users/session/:id' do
end


before '/secret' do
  if session[:email]
    erb :secret
  else
    erb :logout
  end

end


get '/' do
  # La siguiente linea hace render de la vista
  # que esta en app/views/index.erb
  session.clear
  erb :index_user

end

get '/register_temp' do

  erb :register

end

get '/login_temp' do
  erb :login
end

get '/secret' do
  erb :secret
end

get '/logout' do
  session.clear
  erb :index_user
end

post '/registro' do
  # La siguiente linea hace render de la vista
  # que esta en app/views/index.erb
  @user_name = params[:Usuario]
  # p @user_name
  @user_mail = params[:Mail]
  # p @user_mail
  @user_pass = params[:Contraseña]
  # p @user_pass

  User.create(usuario: @user_name, mail: @user_mail, password: @user_pass)

  erb :index_user
end

post '/login' do

  @user_mail = params[:Mail]
  # p @user_mail
  @user_pass = params[:Contraseña]
  # p @user_pass
  val_user = User.authenticate(@user_mail, @user_pass)
  # p @val_user
  if val_user
    session[:id] = val_user.id
    session[:email] = val_user.mail
    session[:user_name] = val_user.usuario
    redirect to '/secret'
  else
    session[:error_message] = "No son correctos tus datos"
    redirect to '/login_temp'
  end

end
