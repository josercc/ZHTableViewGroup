Pod::Spec.new do |s|
  s.name         = "ZHTableViewGroup"
  s.version      = "1.1.0"
  s.summary      = "Manger UITableView DataSource More Cell Style"
  s.description  = <<-DESC
  Management of the library can be very easy to UITableView show different style of the Cell, back off and configuration by means of using Block Cell, you as long as the UITableViewDataSource and UITableDelegate execute the corresponding code
                   DESC
  s.homepage     = "https://github.com/15038777234/ZHTableViewGroup"
  s.license      = "MIT"
  s.author             = { "15038777234" => "15038777234@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/15038777234/ZHTableViewGroup", :tag => s.version }
  s.source_files  = "ZHTableViewGroup/ZHTableViewSource/*.{h,m}"

  s.requires_arc = true
end
