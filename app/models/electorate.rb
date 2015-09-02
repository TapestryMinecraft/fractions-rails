# == Schema Information
#
# Table name: electorates
#
#  id          :integer          not null, primary key
#  fraction_id :integer          not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Electorate < ActiveRecord::Base
  # TODO dependent destroy
  validates :fraction, :name, presence: true
  # TODO does order of scope have to match migration?
  # TODO can scope be :fraction instead of :fraction_id?
  validates :name, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :fraction

  # has_many :electorate_memberships
  # has_many :characters, through: :electorate_memberships

  # TODO differentiate between given/received authorizations
  has_many :government_authorizations, as: :authorizer
  has_many :government_authorizations, as: :authorizee
end
