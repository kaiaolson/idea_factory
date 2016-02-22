require 'rails_helper'

RSpec.describe "ideas/edit", type: :view do
  before(:each) do
    @idea = assign(:idea, Idea.create!(
      :title => "MyString",
      :description => "",
      :user => nil
    ))
  end

  it "renders the edit idea form" do
    render

    assert_select "form[action=?][method=?]", idea_path(@idea), "post" do

      assert_select "input#idea_title[name=?]", "idea[title]"

      assert_select "input#idea_description[name=?]", "idea[description]"

      assert_select "input#idea_user_id[name=?]", "idea[user_id]"
    end
  end
end
