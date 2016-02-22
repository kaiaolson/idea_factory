require 'rails_helper'

RSpec.describe "memberships/show", type: :view do
  before(:each) do
    @membership = assign(:membership, Membership.create!(
      :user => nil,
      :idea => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
