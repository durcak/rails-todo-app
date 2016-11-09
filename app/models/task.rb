class Task < ApplicationRecord
  belongs_to :list
  validates :name, :presence => true
  validates :list_id, :presence => true
  validates :priority, :presence => true, numericality: true

  default_scope { where('completed_at IS NULL AND deleted_at IS NULL')  }
  default_scope { order(priority: :asc) }

  scope :completed, -> { where('completed_at IS NOT NULL AND deleted_at IS NULL') }
  scope :not_completed, -> { where('completed_at IS NULL AND deleted_at IS NULL') }
  scope :not_deleted, -> { where(:deleted_at => nil) }
  scope :deleted, -> { where("deleted_at IS NOT NULL") }
  scope :important, -> { where('priority < 0') }

  def completed? #vrati true aj je hotova
    !completed_at.blank?
    #completed_at.present?
  end

  def deleted?  #vrati true ak je zmazana
    !completed_at.blank?
    #!deleted_at.blank?
    #deleted_at.present?
  end

  def post_tasks(list_id)
    with_exclusive_scope { find(all, :conditions => {:post_id => post_id}) }
  end


end
