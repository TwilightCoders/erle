require 'spec_helper'

RSpec.describe ERLE::Ref do

  it 'returns Ref' do
    input = "#Ref<1.2.3>"

    output = ["1", "2", "3"]

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

  it 'raises if no close' do
    input = "#Ref<1.2.3"

    expect{ERLE.parse(input)}.to raise_error(ERLE::ParserError)
  end

end
