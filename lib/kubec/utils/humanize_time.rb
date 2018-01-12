module Kubec
  module Utils
    # :nodoc:
    module HumanizeTime
      PAIRS = [
        [60, :seconds],
        [60, :minutes],
        [24, :hours],
        [1000, :days]
      ].freeze

      SHORT = {
        seocnds: 's',
        minutes: 'm',
        hours:   'h',
        days:    'd'
      }.freeze

      class << self
        def humanize(secs, short: false, join: true)
          list = convert(secs).map do |(count, name)|
            if short
              "#{count}#{SHORT[name]}"
            else
              "#{count} #{name}"
            end
          end
          return list unless join
          list.join(' ')
        end

        def convert(secs)
          PAIRS.dup.map do |count, name|
            next unless secs > 0
            secs, n = secs.divmod(count)
            [n, name]
          end.compact.reverse
        end
      end
    end
  end
end
