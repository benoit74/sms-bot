# Specs in this file have access to a helper object that includes
# the SfrBoxHelper. For example:
#
# describe SfrBoxHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

ENV['SFR_BOX_MAC']="44:ce:7d:99:99:99"

RSpec.describe SfrBoxHelper, :type => :helper do
    describe "is connected to correct network" do
        it "validates on a correct network" do
            content = "garbage   s f   d44:ce:7d:99:99:99gdd garbage"
            expect(SfrBoxHelper.isCorrectNetwork(content)).to eq(true)
        end
        it "does not validate on a incorrect network" do
            content = "garbage   s f   d44:ce:7d:66:66:66gdd garbage"
            expect(SfrBoxHelper.isCorrectNetwork(content)).to eq(false)
        end
        it "does not validate on a missing content" do
            content = nil
            expect(SfrBoxHelper.isCorrectNetwork(content)).to eq(false)
        end
        it "does not validate on a empty content" do
            content = ""
            expect(SfrBoxHelper.isCorrectNetwork(content)).to eq(false)
        end
    end
end