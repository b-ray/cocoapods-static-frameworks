module Pod
  module Generator
    module XCConfig
      class PodXCConfig

        def generate
          target_search_paths = target.build_headers.search_paths(target.platform)
          sandbox_search_paths = target.sandbox.public_headers.search_paths(target.platform)
          search_paths = target_search_paths.concat(sandbox_search_paths).uniq

          config = {
            'FRAMEWORK_SEARCH_PATHS' => '$(inherited) ',
            'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) COCOAPODS=1',
            'HEADER_SEARCH_PATHS' => XCConfigHelper.quote(search_paths),
            'LIBRARY_SEARCH_PATHS' => '$(inherited) ',
            'OTHER_LDFLAGS' => XCConfigHelper.default_ld_flags(target, @test_xcconfig),
            'PODS_ROOT' => '${SRCROOT}',
            'PODS_TARGET_SRCROOT' => target.pod_target_srcroot,
            'PRODUCT_BUNDLE_IDENTIFIER' => 'org.cocoapods.${PRODUCT_NAME:rfc1034identifier}',
            'SKIP_INSTALL' => 'YES',
            'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) ',
            'MACH_O_TYPE' => 'staticlib',
            # 'USE_HEADERMAP' => 'NO'
          }

          @xcconfig = Xcodeproj::Config.new(config)

          XCConfigHelper.add_settings_for_file_accessors_of_target(nil, target, @xcconfig)
          target.file_accessors.each do |file_accessor|
            @xcconfig.merge!(file_accessor.spec_consumer.pod_target_xcconfig)
          end
          XCConfigHelper.add_target_specific_settings(target, @xcconfig)
          recursive_dependent_targets = target.recursive_dependent_targets
          @xcconfig.merge! XCConfigHelper.settings_for_dependent_targets(target, recursive_dependent_targets, @test_xcconfig)
          if @test_xcconfig
            test_dependent_targets = [target, *target.recursive_test_dependent_targets].uniq
            @xcconfig.merge! XCConfigHelper.settings_for_dependent_targets(target, test_dependent_targets - recursive_dependent_targets, @test_xcconfig)
            XCConfigHelper.generate_vendored_build_settings(nil, target.all_test_dependent_targets, @xcconfig)
            XCConfigHelper.generate_other_ld_flags(nil, target.all_test_dependent_targets, @xcconfig)
            XCConfigHelper.generate_ld_runpath_search_paths(target, false, true, @xcconfig)
          end
          @xcconfig
        end

      end
    end
  end
end
