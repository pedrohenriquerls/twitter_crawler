require 'spec_helper'
require 'byebug'

describe Tweet do

  it 'should invalid content' do
    subject = FactoryGirl.build(:ipsum)
    subject.content = ''
    expect(subject.valid?).to be(false)

    subject.content = 'Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis. Pra lá ,
                     depois divoltis porris, paradis. Paisis, filhis, espiritis santis.'
    expect(subject.valid?).to be(false)
  end

  it 'should a valid content' do
    subject = FactoryGirl.build(:ipsum)
    subject.content = 'Mussum ipsum cacilds, vidis litro abertis. Consetis adipiscings elitis.'
    expect(subject.valid?).to be(true)
  end
end