require 'rails_helper'

RSpec.describe "memberships/edit", type: :view do
  before(:each) do
    @membership = assign(:membership, Membership.create!(
      :user => nil,
      :idea => nil
    ))
  end

  it "renders the edit membership form" do
    render

    assert_select "form[action=?][method=?]", membership_path(@membership), "post" do

      assert_select "input#membership_user_id[name=?]", "membership[user_id]"

      assert_select "input#membership_idea_id[name=?]", "membership[idea_id]"
    end
  end
end
