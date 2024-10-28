class User
  include Mongoid::Document

  class Account
    include Mongoid::Document
    embedded_in :user

    field :provider, type: String
    validates :provider, presence: true

    field :uid, type: String
    validates :uid, presence: true

    field :email, type: String
    validates :email, presence: true
  end
  embeds_many :accounts

  class UserApp
    include Mongoid::Document
    embedded_in :user

    belongs_to :app, class_name: 'AtticApp'
  end
  embeds_many :user_apps

  # has_many :apps, class_name: 'AtticApp'
end
