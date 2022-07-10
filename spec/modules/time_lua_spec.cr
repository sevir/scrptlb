require "../spec_helper"
require "../../src/modules/time_lua.cr"

describe TimeLua do
  stack = Lua.load
  stack.set_global "time", TimeLua.new

  it "time.sleep" do
    return_value = stack.run %q{
      time.sleep(1)
    }

    return_value.should eq(nil)
  end

  it "time.now" do
    return_value = stack.run %q{
      local now = time.now()
      print(now)
      return time.now()
    }

    return_value.should eq(Time.local.to_s("%Y-%m-%d %H:%M:%S %z"))
  end

  it "time.now with format" do
    return_value = stack.run %q{
      time.set_format("%Y-%m-%d %H:%M:%S")
      local now = time.now()
      print(now)
      return time.now()
    }

    return_value.should eq(Time.local.to_s("%Y-%m-%d %H:%M:%S"))
  end
end
