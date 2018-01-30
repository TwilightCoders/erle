require 'spec_helper'

RSpec.describe ERLE::Enum do


  it 'ends with atom' do
    input = "{'bar', a, 'fiz',foop}"
    output = {"bar"=>[:a, "fiz", :foop]}

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

  it 'syntax error' do
    input = "[1,2,3"

    expect{ERLE.parse(input)}.to raise_error(ERLE::ParserError)
  end

end
