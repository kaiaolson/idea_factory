require 'rails_helper'

RSpec.describe "memberships/new", type: :view do
  before(:each) do
    assign(:membership, Membership.new(
      :user => nil,
      :idea => nil
    ))
  end

  it "renders new membership form" do
    render

    assert_select "form[action=?][method=?]", memberships_path, "post" do

      assert_select "input#membership_user_id[name=?]", "membership[user_id]"

      assert_select "input#membership_idea_id[name=?]", "membership[idea_id]"
    end
  end
end
