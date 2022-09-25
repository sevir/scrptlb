require "../spec_helper"
require "../../src/modules/http_lua.cr"

describe ShellLua do
  stack = Lua.load
  stack.set_global "shell", ShellLua.new

  # Runs command
  it "shell.run" do
    return_value = stack.run %q{
      local shell_result = shell.run("echo 'test'")
      return shell_result
    }

    return_value.should eq(true)
  end

  # Runs many commands
  it "shell.run.lines" do
    return_value = stack.run %q{
      local shell_result = shell.run [=[ 
        echo 'test1'
        echo 'test2'
        false
      ]=]
      return shell_result
    }

    # Last false always returns error
    return_value.should eq(false)
  end

  it "shell.exec" do
    return_value = stack.run %q{
        local shell_output = shell.exec [=[
            echo 'prueba'
         ]=]
        return shell_output
    }
    
    return_value.should eq("test")
  end
end
