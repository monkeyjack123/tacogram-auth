class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by({ "email" => params["email"] })

    if user == nil
      flash["notice"] = "No account found with that email."
      redirect_to "/login"
    else
      if user.authenticate(params["password"])
        session["user_id"] = user["id"]
        flash["notice"] = "Logged in."
        redirect_to "/posts"
      else
        flash["notice"] = "Wrong password."
        redirect_to "/login"
      end
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Logged out."
    redirect_to "/login"
  end
end
