class Image
  include Mongoid::Document
  include Mongoid::Paperclip

  field :width, type: Integer
  field :height, type: Integer

  has_mongoid_attached_file :file,
                            styles: ->(attachment) { attachment.instance.styles },
                            path: 'public/images/:id/:style.:extension'

  validates_presence_of :file, :width, :height
  validates_numericality_of :width, :height, greater_than: 0
  validates_attachment_content_type :file, content_type: %w[image/jpeg image/gif image/png]
  validates_attachment_size :file, less_than: 5.megabytes

  after_create :reprocess_image

  def reprocess_image
    file.reprocess!
  end

  def styles
    { resize: "#{width}x#{height}!" }
  end

  def to_json(options = {})
    params = {
      url: file.url(:resize),
      width: width,
      height: height
    }
    JSON.pretty_generate(params, options)
  end
end
