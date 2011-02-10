begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

task :default => 'test:run'
task 'gem:release' => 'test:run'

ver = `cat version.txt`.strip

Bones {
  name         'tiny_xml_builder'
  version      ver
  authors      'Alexandru Ungur'
  email        'alexaandru@gmail.com'
  url          'http://rubygems.com/gems/tiny_xml_builder'
  readme_file  'README.asciidoc'
  ignore_file  '.gitignore'
  depend_on    'blankslate'
}
