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
    FileUtils.rm_rf(project.get_build_dir)
  end

  def init(id)
    project = Project.get(id)
    maven_init(project)
    count_tests(project)
  end

  def clone_or_pull(p)
    dir = p.get_build_dir
    puts "clone in #{p.get_build_dir}"
    unless Dir.exists?(p.get_build_dir)
      system("/usr/bin/git clone #{p.url} #{p.get_build_dir}")
    end
    system("cd #{p.get_build_dir} && /usr/bin/git pull")
  end

  def maven(project)
    clone_or_pull(project) 
    pom_file=File.dirname(__FILE__) + "/../maven/pom.xml"
    FileUtils.cp "#{pom_file}", "#{project.get_build_dir}"
    test_file=File.dirname(__FILE__) + "/../maven/TestConvertNum2Text.java"
    FileUtils.cp "#{test_file}", "#{project.get_build_dir}/src/test/java/iut/tdd/"
    cmd = "cd #{project.get_build_dir} && /usr/bin/mvn test > #{project.get_build_dir}/build.log 2>&1"
    puts "doing #{cmd}"
    out = system(cmd)
    puts "maven #{out}"
    #$?.exit_code
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
      maven(project)
      count_tests(project)
      puts "ok"
    end
  end

  def script
    f = File.new('/tmp/build', 'w')
    f.write("#!/bin/bash\n")
    pom_file=File.dirname(__FILE__) + "/../maven/pom.xml"
    Project.all.each do |project|
      f.write "[ -f \"#{project.get_build_dir}\" ] && rm -rf #{project.get_build_dir}\n"
      f.write "if [ -d \"#{project.get_build_dir}\" ] \n"
      f.write "then\n"
      f.write "  cd #{project.get_build_dir} && GIT_SSL_NO_VERIFY=true /usr/bin/git pull\n"
      f.write "else\n"
      f.write "  GIT_SSL_NO_VERIFY=true /usr/bin/git clone #{project.url} #{project.get_build_dir}\n"
      f.write "fi\n"
      f.write "cp #{pom_file} #{project.get_build_dir}/\n"
      f.write "cd #{project.get_build_dir} && /usr/bin/mvn test > #{project.get_build_dir}/build.log 2>&1\n"
      f.write "\n" 
    end
    f.close

  end

end
