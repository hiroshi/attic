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
end
