require 'rails_helper'

describe Friending do

  describe 'validations' do
    it 'must have user being friended' do
      invalid_friending = build(:friending, friended: nil)
      expect(invalid_friending).to be_invalid
      valid_friending = build(:friending, friended: create(:user))
      expect(valid_friending).to be_valid
    end

    it 'must have user doing the friending' do
      invalid_friending = build(:friending, friender: nil)
      expect(invalid_friending).to be_invalid
      valid_friending = build(:friending, friender: create(:user))
      expect(valid_friending).to be_valid
    end

    it 'must have a unique combination of user ids' do
      friender, friended = create(:user), create(:user)
      create(:friending, friender: friender,
             friended: friended)
      duplicate = build(:friending, friender: friender,
                        friended: friended)
      expect(duplicate).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to user being friended' do
      friending = build(:friending)
      expect(friending).to respond_to(:friended)
    end

    it 'belongs to user doing the friending' do
      friending = build(:friending)
      expect(friending).to respond_to(:friender)
    end
  end

end

