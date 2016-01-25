require 'replay_option'

RSpec.describe ReplayOption do

  it "has replay option of Y" do
    expect(ReplayOption::Y.include?("Y")).to be true
  end
end
