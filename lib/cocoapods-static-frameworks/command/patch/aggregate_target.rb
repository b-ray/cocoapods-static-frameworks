module Pod
  class AggregateTarget < Target

    def framework_paths_by_config
      @framework_paths_by_config ||= begin
        framework_paths_by_config = {}
        user_build_configurations.keys.each do |config|
          relevant_pod_targets = pod_targets.select do |pod_target|
            !pod_target.should_build? && pod_target.include_in_build_config?(target_definition, config)
          end
          framework_paths_by_config[config] = relevant_pod_targets.flat_map(&:framework_paths)
        end
        framework_paths_by_config
      end
    end

    def resource_paths_by_config
      @resource_paths_by_config ||= begin
        relevant_pod_targets = pod_targets
        user_build_configurations.keys.each_with_object({}) do |config, resources_by_config|
          resources_by_config[config] = relevant_pod_targets.flat_map do |pod_target|
            next [] unless pod_target.include_in_build_config?(target_definition, config)
            (pod_target.resource_paths + [bridge_support_file].compact).uniq
          end
        end
      end
    end

  end
end
