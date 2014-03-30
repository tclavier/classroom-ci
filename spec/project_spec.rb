require 'spec_helper'

describe 'Project model' do
  before(:all) do
    p = Project.new()
    p.url = 'https://git.iut-info.univ-lille1.fr/thomas.clavier/tp_tdd_test.git'
    @project = p.save || Project.find(:url => p.url).first
  end

  it "build project must change points" do 
    ctrl = ProjectControler.new
    ctrl.build(@project.id)
    @project.reload.points.should be > 0
  end

  it "clone project must return true" do
    ctrl = ProjectControler.new
    code = ctrl.clone_or_pull(@project)
    expect(code).to eq(0)
  end

  it "project build path is in /tmp" do
    expect(@project.get_build_dir).to eq("/tmp/project_#{@project.id}")
  end

  it "maven must return true" do
    ctrl = ProjectControler.new
    code = ctrl.maven(@project)
    expect(code).to eq(0)
  end

  it "count test without test must return 0" do
    ctrl = ProjectControler.new
    code = ctrl.maven(@project)
    ctrl.count_tests(@project)
  end
end
