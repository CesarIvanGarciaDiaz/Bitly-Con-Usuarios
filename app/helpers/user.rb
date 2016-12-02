helpers do
  # Esto deberá de regresar al usuario con una sesión actual si es que existe 
  def current_user
    if session[:id]
      User.find(session[:id])
    else
      nil
    end

  end

  # Regresa true si el current_user existe y false de otra manera 
  def logged_in?
    if current_user
      true
    else 
      false
    end
  end
end