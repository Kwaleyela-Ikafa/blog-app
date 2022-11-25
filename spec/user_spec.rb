require 'rails_helper'

describe User do
    it { should validate_presence_of(:name) }
end

#     before do
#         @user = User.create!(name: nil)
#     end

#     it "Is invalide if name is nil"
#       expect(name:nil).should_not be_valid
# end