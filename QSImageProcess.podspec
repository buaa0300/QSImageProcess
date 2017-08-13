Pod::Spec.new do |s|
s.name         = "QSImageProcess"
s.version      = "1.0.0"
s.summary      = "A tool for process local image or web image"
s.homepage     = "https://github.com/buaa0300/QSImageProcess"
s.license      = "MIT"
s.authors      = {"南华coder" => "buaa0300@163.com"}
s.platform     = :ios, "7.0"
s.source       = {:git => "https://github.com/buaa0300/QSImageProcess.git", :tag => s.version}
s.requires_arc = true
s.source_files = "QSImageProcess/*"
s.dependency  "QSDispatchQueue"
s.dependency  "SDWebImage", "~>4.1.0"
end
