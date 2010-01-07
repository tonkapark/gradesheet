class InvitesController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]
  before_filter :find_invite, :except => [:index, :new, :create]
  
  def index
    @invites = Invite.all
  end
  
  def show
  end
  
  def new
    @invite = Invite.new
  end
  
  def create
    @invite = Invite.new(params[:invite])
    if @invite.save
      flash[:notice] = "Successfully created invite."
      redirect_to @invite
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @invite.update_attributes(params[:invite])
      flash[:notice] = "Successfully updated invite."
      redirect_to @invite
    else
      render :action => 'edit'
    end
  end
  
  def destroy    
    @invite.destroy
    flash[:notice] = "Successfully destroyed invite."
    redirect_to invites_url
  end
  
  def send_invitation    
    @invite.invite!
    Mailer.deliver_invitation(@invite)
    flash[:notice] = "Invite sent to #{@invite.email}"
    redirect_to(invites_url)
  end  

protected
  def find_invite
    @invite = Invite.find(params[:id])
  end
  
end
