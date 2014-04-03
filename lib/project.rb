# encoding: utf-8

class Project 
  include DataMapper::Resource
  property :id,         Serial
  property :url,        Text, required:true, :unique => true
  property :student,    Text
  property :points,     Float, default:0.0
  property :rouge,      Integer, default:0
  property :vert,       Integer, default:0
  property :last_build, DateTime    
  
  def get_build_dir
    "/tmp/project_#{id}"
  end
end

class ProjectControler
  def build_project(id)
    project = Project.get(id)
    maven(project)
    count_tests(project)
  end

  def init(id)
    project = Project.get(id)
    maven_init(project)
    count_tests(project)
  end

  def clone_or_pull(p)
    dir = p.get_build_dir
    if (Dir.exists? dir ) 
      cmd = "GIT_SSL_NO_VERIFY=true /usr/bin/git -C #{dir} pull"
    else
      cmd = "GIT_SSL_NO_VERIFY=true /usr/bin/git clone #{p.url} #{dir}"
    end
    puts "doing #{cmd}"
    puts %x[ #{cmd} ]
    puts "git ok"
  end

  def maven(project)
    clone_or_pull(project) 
    pom_file=File.dirname(__FILE__) + "/../maven/pom.xml"
    FileUtils.cp "#{pom_file}", "#{project.get_build_dir}"
    cmd = "cd #{project.get_build_dir} && /usr/bin/mvn test > #{project.get_build_dir}/build.log 2>&1"
    puts "doing #{cmd}"
    puts %x[ #{cmd} ]
    puts "maven ok"
  end

  def count_tests(project)
    puts "Counting points"
    if File.exist? ("#{project.get_build_dir}/build.log") 
      open("#{project.get_build_dir}/build.log").grep(/^Tests/).each do |line|
        all, red, err, skip = /^Tests run:\s(\d+), Failures:\s(\d+), Errors:\s(\d+), Skipped:\s(\d+)/.match(line).captures
        puts line
        vert = all.to_i - red.to_i - err.to_i - skip.to_i
        rouge = red.to_i

        if (vert > project.vert)
          project.points += 1
        else 
          if (vert < project.vert )
            project.points -= 1
          else 
            project.points -= 0.1
          end 
        end

        project.rouge = rouge
        project.vert = vert
      end
    else
      project.points = 0
    end
    project.last_build = DateTime.now
    project.save
  end

  def perform
    Project.all.each do |project|
      puts "doing project #{project.url}"
      build_project(project.id)
      puts "ok"
    end
  end

end
