# encoding: utf-8

class Project 
  include DataMapper::Resource
  property :id,      Serial
  property :url,     Text, required:true, :unique => true
  property :student, Text
  property :points,  Float, default:0.0
  has n,   :builds
  
  def get_build_dir
    "/tmp/project_#{id}"
  end
end

class Build
  include DataMapper::Resource
  property :id,    Serial
  property :date,  DateTime
  property :note,  Float
  property :green, Integer
  property :red,   Integer
  belongs_to :project
end

class ProjectControler
  def build(id)
    project = Project.get(id)
    maven(project)
    if (project.points == 0)
      project.points = 1
    end
    project.save
  end

  def clone_or_pull(p)
    dir = p.get_build_dir
    if (Dir.exists? dir ) 
      cmd = "GIT_SSL_NO_VERIFY=true /usr/bin/git -C #{dir} pull > /tmp/debug 2>&1"
    else
      cmd = "GIT_SSL_NO_VERIFY=true /usr/bin/git clone #{p.url} #{dir} > /tmp/debug 2>&1"
    end
    system(cmd)
    $?.exitstatus
  end

  def maven(project)
    clone_or_pull(project) 
    pom_file=File.dirname(__FILE__) + "/../maven/pom.xml"
    FileUtils.cp "#{pom_file}", "#{project.get_build_dir}"
    cmd = "cd #{project.get_build_dir} && /usr/bin/mvn test > #{project.get_build_dir}/build.log 2>&1"
    system(cmd)
    $?.exitstatus
  end
  
  def count_tests(project)
    open("#{project.get_build_dir}/build.log").grep(/^Tests/).each do |line|
      all, red, err, skip = /Tests run: \d+, Failures: \d+, Errors: \d+, Skipped: \d+/.match(line).captures
      build = Build.new
      build.red = red;
      build.green = all - red - err - skip
      project.builds << build
      project.save
    end
    #unless File.directory? project.get_build_dir+"/target/surefire-reports/"
    #  return 0
    #end
    #Dir.foreach(project.get_build_dir+"/target/surefire-reports/") do |file|
    #  next if item == '.' or item == '..'
    #  if file.match(/^.*\.xml$/i) 
    #    puts file
    #  end
    #end
  end

end
