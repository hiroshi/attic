class AtticApp
  include Mongoid::Document
  store_in collection: 'apps'

  # belongs_to :user, required: true

  field :name, type: String
  validates :name, presence: true

  class Domain
    include Mongoid::Document
    embedded_in :app, class_name: 'AtticApp'

    field :name, type: String
    validates :name, presence: true
  end
  embeds_many :domains

  class Owner
    include Mongoid::Document
    embedded_in :app, class_name: 'AtticApp'

    belongs_to :user, required: true
  end
  embeds_many :owners

  class ResourceType
    include Mongoid::Document
    embedded_in :app, class_name: 'AtticApp'

    field :name, type: String
    validates :name, presence: true

    class ResourceField
      include Mongoid::Document
      embedded_in :resource_type

      field :name, type: String
      validates :name, presence: true

      field :type, type: Symbol
      validates :type, presence: true
    end
    embeds_many :resource_fields
  end
  embeds_many :resource_types
end
