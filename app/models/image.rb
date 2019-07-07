class Image
  include Mongoid::Document
  include Mongoid::Paperclip

  field :width, type: Integer
  field :height, type: Integer

  has_mongoid_attached_file :file,
                            styles: ->(attachment) { attachment.instance.styles },
                            url: 'public/images/:id/:style.:extension',
                            path: ':url'

  belongs_to :user

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

  def as_json(options = {})
    super(only: [:width, :height]).merge(url: file.url(:resize))
  end
end
