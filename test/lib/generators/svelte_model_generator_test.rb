require "test_helper"
require "generators/svelte_model/svelte_model_generator"

class SvelteModelGeneratorTest < Rails::Generators::TestCase
  tests SvelteModelGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
