# == Schema Information
#
# Table name: events
#
#  id            :integer         not null, primary key
#  date          :integer
#  time          :integer
#  description   :string(255)
#  collection_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
