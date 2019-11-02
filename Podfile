# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def commonPods
  pod 'Reachability'
end

target 'GJContactsDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  commonPods

  target 'GJContactsDemoTests' do
    inherit! :search_paths
    commonPods
  end

  target 'GJContactsDemoUITests' do
    inherit! :search_paths
    commonPods
  end

end
