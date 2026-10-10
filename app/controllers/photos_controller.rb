class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show send_email]

  def index
    @photos = Photo.order(created_at: :desc)
  end

  def show; end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params.require(:photo).permit(:title, :image))
    if @photo.save
      redirect_to @photo, notice: "Photo added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def send_email
    email = params[:email].to_s.strip
    if email.match?(URI::MailTo::EMAIL_REGEXP)
      PhotoMailer.share_photo(@photo, email).deliver_now
      redirect_to @photo, notice: "Email sent to #{email}."
    else
      redirect_to @photo, alert: "Please enter a valid email address."
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
