require 'spec_helper'

RSpec.describe ERLE::Tuple do

  it 'parses' do
    input = "{a,[{a_foo,'ABCDE',\"ABCDE\",<<\"ABCDE\">>}]}"
    # output = {:a=>[{:a_foo=>["ABCDE", "ABCDE", "ABCDE"]}]}
    # expect(ERLE::Tuple.new(input).to_ruby).to eq(output)

    output = {:a=>[{:a_foo=>["ABCDE", "ABCDE", "ABCDE"]}]}

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

  it 'simple' do
    input = "{a,123}"
    # output = {:a=>[{:a_foo=>["ABCDE", "ABCDE", "ABCDE"]}]}
    # expect(ERLE::Tuple.new(input).to_ruby).to eq(output)

    output = {a: 123}

    obj = ERLE.parse(input)
    expect(obj.to_ruby).to eq(output)
  end

end
