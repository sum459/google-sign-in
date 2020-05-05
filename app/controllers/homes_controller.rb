class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
    @homes = Home.all
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def social_login
    
    provider = request.env["omniauth.auth"]["provider"]

    case provider
    when "google_oauth2"
      if !request.env["omniauth.auth"]["info"]["email"].nil?
        # Login success
        email = request.env["omniauth.auth"]["info"]["email"]
        user = User.find_by(email: email)
        if user.nil?
          # You need to signup before continuing
          flash[:danger] = "Please signup before continuing"
          redirect_to  new_user_registration_path(email: email)
        elsif !user.nil?
          sign_in(user)
          flash[:success] = "Login Successful"
          redirect_to "/"
        end
      else
        # Login failed
        flash[:danger] = "There was an error signing you in"
        redirect_to new_user_session_path
      end
    end
  end

  def social_failure
    flash[:danger] = "There was an error signing you in. Please try again"
    redirect_to new_user_session_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def home_params
      params.fetch(:home, {})
    end
end
