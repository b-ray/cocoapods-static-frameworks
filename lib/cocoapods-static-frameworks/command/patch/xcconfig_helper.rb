module Pod
  module Generator
    module XCConfig
      module XCConfigHelper

        def self.generate_vendored_build_settings(aggregate_target, pod_targets, xcconfig)
          pod_targets.each do |pod_target|
            XCConfigHelper.add_settings_for_file_accessors_of_target(aggregate_target, pod_target, xcconfig)
          end
        end

      end
    end
  end
end
