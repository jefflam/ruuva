# == Schema Information
#
# Table name: products
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  description   :string(255)
#  price         :string(255)
#  likes         :integer
#  collection_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  product_image :string(255)
#  url           :string(255)
#

require 'spec_helper'

describe Product do
  pending "add some examples to (or delete) #{__FILE__}"
end
