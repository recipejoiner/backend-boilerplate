class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include ActionController::Cookies
  def facebook
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
      return # be sure to include an return if there is code after this otherwise it will be executed
    end
    # This method is implemented in the user model
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      cookies[:usertoken] = {
        value: @user.token,
        expires: 1.year,
        domain: :all
      }
      if Rails.env.development?
        redirect_to "https://devwork.shmob:8000/#"
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      msg = {:error => "Error with logging in/signing up this user."}
      render :json => msg
    end
  end

  def failure
    msg = {:error => "Unknown error."}
    render :json => msg
  end
end