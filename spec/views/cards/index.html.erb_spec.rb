require 'spec_helper'

describe "cards/index" do
  before(:each) do
    assign(:cards, [
      stub_model(Card,
        :task => "Task",
        :code => "MyText"
      ),
      stub_model(Card,
        :task => "Task",
        :code => "MyText"
      )
    ])
  end

  it "renders a list of cards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Task".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
