module ActiveRecord
  class Errors
    @@default_error_messages = {
      :inclusion => "n�o est� inclu�do na lista.",
      :exclusion => "est� reservado.",
      :invalid => "� inv�lido.",
      :confirmation => "n�o corresponde � confirma��o.",
      :accepted  => "deve ser aceito.",
      :empty => "n�o pode estar vazio.",
      :blank => "n�o pode estar em branco.",
      :too_long => "� muito longo (m�ximo %d caracteres).",
      :too_short => "� muito curto (m�nimo %d caracteres).",
      :wrong_length => "� de comprimento errado (deveria ter %d caracteres).",
      :taken => "j� est� em uso.",
      :not_a_number => "n�o � um n�mero."
    }
  end
end
