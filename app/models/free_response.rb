class FreeResponse < ActiveRecord::Base

  belongs_to :student_exercise

  mount_uploader :attachment, FreeResponseUploader

  acts_as_numberable :container => :student_exercise,
                     :table_class => FreeResponse

  attr_accessible :attachment, :content, :content_type, :student_exercise_id

  validates :student_exercise_id, :presence => true
  validates :type, :presence => true
  validate :updatable?

  def updatable?
    student_exercise.free_responses_can_be_updated?
  end

  #############################################################################
  # Access control methods
  #############################################################################

  def can_be_read_by?(user)
    user.can_read?(student_exercise)
  end
    
  def can_be_created_by?(user)
    user.can_update?(student_exercise)
  end
  
  def can_be_updated_by?(user)
    user.can_update?(student_exercise)
  end
  
  def can_be_destroyed_by?(user)
    user.can_update?(student_exercise)
  end

  def can_be_sorted_by?(user)
    user.can_update?(student_exercise)
  end

end