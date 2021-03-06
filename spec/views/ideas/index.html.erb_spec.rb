require 'rails_helper'

RSpec.describe "ideas/index", type: :view do
  before(:each) do
    assign(:ideas, [
      Idea.create!(
        :title => "Title",
        :description => "",
        :user => nil
      ),
      Idea.create!(
        :title => "Title",
        :description => "",
        :user => nil
      )
    ])
  end

  it "renders a list of ideas" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
