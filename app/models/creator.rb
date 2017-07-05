class Creator
  include CreatorHelper
  include ControllerCreator
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :name, type: String
  field :info, type: String

  embeds_many :model_fields, inverse_of: :creator
  accepts_nested_attributes_for :model_fields, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false

private

  after_save do |doc|
    create_model(doc)
    create_controller(doc)
    create_route(doc)
  end

  before_destroy do |doc|
    destroy_route(doc)
    destroy_model(doc)
    destroy_controller(doc)
  end
end
