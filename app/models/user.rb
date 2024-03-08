class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :meals
  has_many :recipes
  # has_many :favorite_meals, through: :recipes, source: :meal

  def gasto_calorico
    if sex == "Masculine"
    66.763 + (13.751 * self.weight) + (5.0033 * self.height) - (6.55 * self.age)
    elsif sex == "Feminine"
    665.51 + (9.463 * self.weight) + (1.8 * self.height) - (4.6756 * self.age)
    else
      0
    end
  end

  def requerimientos
    gc = self.gasto_calorico
    {
      poca_actividad: gc * 1.375,
      actividad_moderada: gc * 1.55,
      actividad_intensa: gc * 1.725
    }
  end
end

# Hombres: calorías del BMR = 66,473 + (13,751 x masa (kg)) + (5,0033 x estatura (cm)) – (6,55 x edad (años))
# Mujeres: calorías del BMR = 665,51 + (9,463 x masa (kg)) + (1,8 x estatura (cm)) – (4,6756 x edad (años))

# BMR x 1,375: si eres sedentario o realizas poca actividad física. Esto es si haces ejercicio menos de 3 veces a la semana, pongamos, por ejemplo, salir a caminar. En el caso de ser sedentario, se recomienda incluso restar entre 100 y 200 calorías. Según tu nivel de inactividad.
# BMR x 1,55: si tu actividad física es moderada, lo que quiere decir hacer ejercicio entre 3 y 5 veces a la semana.
# BMR x 1,725: si realizas actividad física intensa, esto sería si practicas ejercicio más de 5 veces por semana.

#Mostrar gasto calorico
#<p>Gasto calórico basal: <%= current_user.gasto_calorico %> kcal</p>

#Mostrar requerimientos
#<% requerimientos = current.requerimientos %>
#<p>Requerimientos calóricos para poca actividad: <%= requerimientos[:poca_actividad] %> kcal</p>
#<p>Requerimientos calóricos para actividad moderada: <%= requerimientos[:actividad_moderada] %> kcal</p>
#<p>Requerimientos calóricos para actividad intensa: <%= requerimientos[:actividad_intensa] %> kcal</p>
