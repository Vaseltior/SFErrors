require 'rubygems'
require 'xcodeproject'

SWIFT2OBJC_PROJECT_NAME = "SFErrors"
SWIFT2OBJC_PROJECT_TARGET = "SFErrors"

proj = XcodeProject::Project.new('./'+SWIFT2OBJC_PROJECT_NAME+'.xcodeproj')
data = proj.read

# Print targets of the project
p "TARGETS:"
data.targets.each do |target|
    puts target.name
end

target = data.target(SWIFT2OBJC_PROJECT_TARGET)

p "GROUPS:"
data.main_group.children.each do |child|
    p child.name
    p child.total_path
end

group = data.group('/')
group.files.each do |file|
    p file.name
end
