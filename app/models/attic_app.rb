class AtticApp
  include Mongoid::Document
  store_in collection: 'apps'

  # belongs_to :user, required: true

  field :name, type: String
  validates :name, presence: true

  class AppOwner
    include Mongoid::Document
    embedded_in :app, class_name: 'AtticApp'

    belongs_to :user, required: true
  end
  embeds_many :app_owners
end
