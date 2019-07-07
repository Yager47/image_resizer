class ResizeOldImage
  prepend SimpleCommand

  def initialize(params = {})
    @old_image_id = params[:id]
    @width = params[:width]
    @height = params[:height]
  end

  def call
    image = user.images.new(width: @width, height: @height)
    image.file = @old_image.file
    if image.save
      image
    else
      errors.add(:image, image.errors)
    end
  end

  private

  def old_image
    @old_image ||= Image.find(@old_image_id)
  end

  def user
    old_image.user
  end
end