# frozen_string_literal: true

module Support
  module Utils
    class << self
      def included(the_guy_who_included_the_module)
        the_guy_who_included_the_module.extend(ClassMethods)
      end
    end

    module ClassMethods
      def get_env_or_raise_exception(name)
        ENV[name] || raise(EnvironmentError, "Environment variable #{name} is not set!")
      end
    end

    class EnvironmentError < StandardError; end
  end
end
