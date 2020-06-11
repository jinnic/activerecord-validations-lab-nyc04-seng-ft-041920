class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :category, inclusion: { in: %w(Fiction Non-Fiction), 
    message: "Category can be only Fiction or Non-Fiction"}
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validate :must_be_clickbaits
 
  
  CLICKBAITS = [
    /won't believe/i,
    /secret/i,
    /top [0-9]*/i,
    /guess/i
  ]

  def must_be_clickbaits
    if title
        #.none on array returns boolean | .match(pattern) on string returns boolean
        if CLICKBAITS.none? {|c| c.match?(title) }
          errors.add(:title, "must be a clickbait")
        end
    end
  end
end
