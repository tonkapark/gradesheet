class UsersController < Clearance::UsersController
   
  # Override and add in a check for invitation code
  def create
    @user = User.new params[:user]
    invite_code = params[:invite_code]
    @invite = Invite.find_redeemable(invite_code)
 
    if invite_code && @invite
      if @user.save
        @invite.redeemed!
        ClearanceMailer.deliver_confirmation @user
        flash[:notice] = "You will receive an email within the next few minutes. " <<
                         "It contains instructions for confirming your account."
        redirect_to url_after_create
      else
        render :action => "new"
      end
    else
      flash.now[:notice] = "Sorry, only invited users are allowed to sign up."
      render :action => "new"
    end
  end
 
end