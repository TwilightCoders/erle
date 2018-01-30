require 'spec_helper'

RSpec.describe ERLE::Binary do

  it 'enclosed' do
    input = "<<a,b>>"
    output = [:a, :b]

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

  it 'syntax error' do
    input = "<<A,B"

    expect{ERLE.parse(input)}.to raise_error(ERLE::ParserError)
  end

end
