require 'rails_helper'

describe Product do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { should validate_presence_of :image }
  it { should validate_presence_of :origin }
  it { should validate_presence_of :variety }
end