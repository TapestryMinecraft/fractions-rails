# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  fraction_id :integer          not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Region < ActiveRecord::Base
  include Governable
  validates :fraction, :name, presence: true
  # TODO does order of scope have to match migration?
  validates :name, uniqueness: { scope: :fraction, case_sensitive: false,
    message: ""}

  belongs_to :fraction
  # TODO not dependent: :destroy, because plot should still store culture;
  # plot must be set to regionless, or transferred to default region
  has_many :plots

  has_many :land_authorizations_given, class_name: 'LandAuthorization', foreign_key: 'authorizer_id', dependent: :destroy
end
