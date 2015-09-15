Gem::Specification.new do |s|
    s.name          = 'whip'
    s.version       = '0.1.0'
    s.executables   << "whip"
    s.date          = '2015-09-15'
    s.summary       = "whip: html inclusion preprocessor."
    s.description   = "A html preprocessor that compile .whip files into .html files."
    s.authors       = ["Ryan Wackelin"]
    s.email         = 'none'
    s.files         = Dir['lib/*.rb'] + Dir['lib/whip/*.rb'] + Dir['lib/whip/cli/*.rb'] + Dir['bin/*'] + Dir['test/**/*']
    #s.homepage     = 'none'
    s.license       = 'MIT'
end