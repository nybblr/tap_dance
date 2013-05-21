
guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^bin/(.+)$})         { "spec" }
  watch(%r{^lib/(.+)\.rb$})     { |m| [ "spec/lib/#{m[1]}_spec.rb", "spec" ] }
  watch('spec/spec_helper.rb')  { "spec" }
end

