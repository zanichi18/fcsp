class Education::Project < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc{|controller| controller.current_user if controller}

  translates :description, :core_features, :release_note

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :rates, class_name: Education::Rate.name, foreign_key: :project_id
  has_many :members, class_name: Education::ProjectMember.name,
    foreign_key: :project_id, dependent: :destroy
  has_many :project_techniques, class_name: Education::ProjectTechnique.name,
    foreign_key: :project_id, dependent: :destroy
  has_many :feedbacks, class_name: Education::Feedback.name,
    foreign_key: :project_id
  has_many :techniques, through: :project_techniques
  has_many :users, through: :members
  has_many :images, class_name: Education::Image.name, as: :imageable

  validates :name, presence: true
  validates :description, presence: true
  validates :core_features, presence: true
  validates :release_note, presence: true
  validates :server_info, presence: true
  validates :pm_url, presence: true
  validates :plat_form, presence: true
  validates :git_repo, presence: true

  scope :newest, ->{order created_at: :desc}
  scope :relation_plat_form, ->plat_name do
    where plat_form: plat_name
  end
  scope :search_by_name, ->term do
    where("LOWER(name) LIKE :term", term: "%#{term.downcase}%")
  end
  scope :filter_by_technique, ->technique_name do
    joins(:techniques).where("education_techniques.name LIKE ?", technique_name)
  end
end
