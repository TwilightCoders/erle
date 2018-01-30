require 'spec_helper'

RSpec.describe ERLE::Term do

  it 'outputs input' do
    input = "foo"
    output = "foo"

    obj = ERLE::Term.new(input)
    expect(obj.to_ruby).to eq(output)
  end

  it 'syntax error' do
    # pid
    input = "<1.2"

    expect{ERLE.parse(input)}.to raise_error(ERLE::ParserError)
  end

end
