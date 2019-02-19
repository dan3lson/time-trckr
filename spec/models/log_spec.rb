require 'rails_helper'

RSpec.describe Log, type: :model do
  it { should_have_many(:logs_tags)}
  it { should_have_many(:tags)}
end
