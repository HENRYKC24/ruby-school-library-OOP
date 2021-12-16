class Corrector
  def correct_name(name)
    len = name.length
    capitalized = name.capitalize.slice(0, 11)
    len > 10 ? "#{capitalized}..." : capitalized
  end
end
