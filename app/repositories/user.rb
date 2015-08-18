class UserRepository
  def self.all
    [
      { lotus_gem: 'lotus', name: 'Andy' },
      { lotus_gem: 'utils', name: 'Jon' },
      { lotus_gem: 'views', name: 'Rob' },
      { lotus_gem: 'model', name: 'Omar' },
      { lotus_gem: 'helpers', name: 'Adre' },
      { lotus_gem: 'controller', name: 'Ben' },
      { lotus_gem: 'router', name: 'Kevin' },
      { lotus_gem: 'validations', name: 'Matt' }
    ]
  end
end
