# == Schema Information
#
# Table name: fractions
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  ancestry     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  founder_id   :integer
#  founder_type :string
#

require 'test_helper'

class FractionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
