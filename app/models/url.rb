require 'random_data'
# require 'uri'

class Url < ActiveRecord::Base
  # Remember to create a migration!
  # validate :uri
  # validates :url_anterior , presence: true , confirmation: true
  # VALID_EMAIL_REGEX = /([https])\w+:+\/+\//
  # validates :url_anterior, format: { :with => VALID_EMAIL_REGEX , message: "El formato del correo es invalido" }
  
  belongs_to :user

  before_create :short_url

  def short_url
    
    @url_corta = Random.alphanumeric(5)
    @url_corta = "bitly" + @url_corta 
    self.url_nueva = @url_corta
  end
  
  # def uri(url_http)
  #   uri = URI.parse(url_http)
  #   validates :url_anterior , presence: true , confirmation: true if uri.scheme != http 
    
  # end

end

