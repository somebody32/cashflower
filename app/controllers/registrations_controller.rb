class RegistrationsController < Devise::RegistrationsController

  protected

  def build_resource(hash = nil)
    if params[resource_name] && params[resource_name][:password].nil?
      chars = ("a".."z").to_a + ("1".."9").to_a
      params[resource_name][:password] =  Array.new(6, '').collect{chars[rand(chars.size)]}.join
    end

    super
  end
end
