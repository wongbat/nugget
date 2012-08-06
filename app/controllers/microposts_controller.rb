class MicropostsController < ApplicationController
  # GET /microposts
  # GET /microposts.json
  def index
    @user = User.find(params[:user_id])
    @microposts = @user.microposts.all

    respond_to do |format|
      format.html
      format.json { render :json => @microposts }
    end
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
    @user = User.find(params[:user_id])
    @micropost = @user.microposts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @micropost }
    end
  end

  # GET /microposts/new
  # GET /microposts/new.json
  def new
    @user = User.find(params[:user_id])
    @micropost= @user.microposts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @micropost }
    end
  end

  # GET /microposts/1/edit
  def edit
    @user = User.find(params[:user_id])
    @micropost = @user.microposts.find(params[:id])
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @user = User.find(params[:user_id])
    @micropost = @user.microposts.build(params[:micropost])

    respond_to do |format|
      if @micropost.save
        format.html { redirect_to user_microposts_path(@user), :notice => 'Micropost was successfully created.' }
        format.json { render :json => @micropost, :status => :created, :location => @micropost }
      else
        format.html { render :action => "new" }
        format.json { render :json => @micropost.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /microposts/1
  # PUT /microposts/1.json
  def update
    @user = User.find(params[:user_id])
    @micropost = @user.microposts.find(params[:id])

    respond_to do |format|
      if @micropost.update_attributes(params[:micropost])
        format.html { redirect_to user_micropost_path, :notice => 'Micropost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @micropost.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @user = User.find(params[:user_id])
    @micropost = @user.microposts.find(params[:id])
    @micropost.destroy

    respond_to do |format|
      format.html { redirect_to user_microposts_path }
      format.json { head :no_content }
    end
  end
end
