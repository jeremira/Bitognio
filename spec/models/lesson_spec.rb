require 'rails_helper'

RSpec.describe Lesson, type: :model do
  let(:lesson) {build :lesson}
  it "has a valid factory" do
    expect(lesson).to be_valid
  end
  it "needs a date" do
    lesson.date = nil
    expect(lesson).to_not be_valid
  end
  it "needs a time" do
    lesson.time = nil
    expect(lesson).to_not be_valid
  end
  it "is not confirmed by default" do
    expect(lesson.confirmed).to be false
  end
  it "is not payed by default" do
    expect(lesson.payed).to be false
  end

end
