require 'spec_helper'

describe "cards/new" do
  before(:each) do
    assign(:card, stub_model(Card,
      :task => "MyString",
      :code => "MyText"
    ).as_new_record)
  end

  it "renders new card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cards_path, :method => "post" do
      assert_select "input#card_task", :name => "card[task]"
      assert_select "textarea#card_code", :name => "card[code]"
    end
  end
end
