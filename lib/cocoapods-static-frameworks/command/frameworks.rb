module Pod
  class Podfile
    def static_frameworks
      require 'cocoapods-static-frameworks/command/patch/aggregate_target.rb'
      require 'cocoapods-static-frameworks/command/patch/pod_xcconfig.rb'
      require 'cocoapods-static-frameworks/command/patch/xcconfig_helper.rb'
    end
  end
end
