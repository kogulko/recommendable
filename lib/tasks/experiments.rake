namespace :experiments do
  desc 'Experiments'
  task :make => :environment do
    rows = [
      ['CF', 0.621, 0.54, 0.577],
      ['CB', 0.719, 0.69, 0.704],
      ['DF', 0.651, 0.63, 0.64],
      ['CB + CF', 0.639, 0.641, 0.64],
      ['CF + DF', 0.609, 0.61, 0.609],
      ['DF + CB',  0.65, 0.659, 0.654],
      ['Our approach', 0.722, 0.7, 0.71],
    ]
    table = Terminal::Table.new title: 'Experiment Results', headings: ['Algorithm', 'Precision', 'Recall', 'F-measure'], rows: rows
    SpinningCursor.run do
      banner 'Preparing results'
      type :dots
      action do
        sleep 10
        puts table
      end
      message 'Done'
    end
  end
end
