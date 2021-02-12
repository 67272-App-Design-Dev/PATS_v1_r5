module Minitest
  module Reporters
    class SpecReporter
      def record(test)
        super
        test_name = test.name.gsub(/^test_: /, 'test: ')
        color = test.failure ? :red : :green
        print(send(color) { pad_test(test_name) })

        print_colored_status(test)
        print(" (%.2fs)" % test.time) unless test.time.nil?
        puts
        if !test.skipped? && test.failure
          print_info(test.failure)
          puts
        end
      end
    end
  end
end