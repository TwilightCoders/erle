require 'spec_helper'

RSpec.describe ERLE::Pid do

  it 'parses' do
    input = "<1.2.3>"
    output = "1.2.3"
    obj = ERLE.to_ruby(input)
    expect(obj).to eq(output)
  end

  it 'renders' do
    input = "<1.2.3>"
    obj = ERLE.to_ruby(input)
    expect(obj.to_erl).to eq(input)
  end

end
