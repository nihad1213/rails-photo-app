class PhotoMailer < ApplicationMailer
  def share_photo(photo, recipient)
    @photo = photo
    attachments[photo.image.filename.to_s] = photo.image.download
    mail(to: recipient, subject: "Photo: #{photo.title}")
  end
end
