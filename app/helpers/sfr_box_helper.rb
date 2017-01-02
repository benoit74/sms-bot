module SfrBoxHelper
    
    def SfrBoxHelper.isCorrectNetwork(home_content)
        if !home_content || home_content.length() == 0
            return false
        end
        return home_content.include? ENV['SFR_BOX_MAC']
    end

end