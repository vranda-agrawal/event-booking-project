class Users::SessionsController < Devise::SessionsController

  protected
  def after_sign_out_path_for(resource_or_scope)
    binding.pry
    new_user_session_path
  end

end
