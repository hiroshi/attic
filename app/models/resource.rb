class Resource
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  belongs_to :app, class_name: 'AtticApp', required: true

  field :name, type: String
  validates :name, presence: true
end
