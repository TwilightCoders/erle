require 'spec_helper'

RSpec.describe ERLE::Number do

  it 'floats' do
    input = "1.232"
    output = 1.232

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

  it 'sinks lol kidding, integers' do
    input = "10"
    output = 10

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

end
