require 'rails_helper'

RSpec.describe "ideas/show", type: :view do
  before(:each) do
    @idea = assign(:idea, Idea.create!(
      :title => "Title",
      :description => "",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
