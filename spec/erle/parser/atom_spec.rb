require 'spec_helper'

RSpec.describe ERLE::Atom do

  it 'enclosed' do
    input = "'foo'"
    output = "foo"

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

  it 'outclosed' do
    input = "foo"
    output = :foo

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

  it 'close syntax error' do
    input = "'foo"

    expect{ERLE.parse(input)}.to raise_error(ERLE::ParserError)
  end

  it 'content syntax error' do
    input = "{@}"

    expect{ERLE.parse(input)}.to raise_error(ERLE::ParserError)
  end

end
