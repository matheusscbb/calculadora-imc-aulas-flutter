class Pessoa {
  double weight;
  double height;
  bool gender;
  double imc = 0;
  int materializeColorScale = 100;

  Pessoa({this.weight, this.height, this.gender});

  String calculateImc() {
    var height = this.height;
    var imc = this.weight / (height * height);
    print(height);
    print(this.weight);
    print(imc);
    return _classifyImc(imc);
  }

  _classifyImc(imc){
      if ((imc < 18.6 && !this.gender) || (imc < 17 && this.gender)) {
        this.materializeColorScale = 100;
        return "Abaixo do peso";

      } else if ((imc < 25.0 && !this.gender) || (imc < 18.5 && this.gender)) {
        this.materializeColorScale = 300;
        return "Peso ideal";

      } else if ((imc < 30.0 && !this.gender) || (imc < 25.0 && this.gender)) {
        this.materializeColorScale = 400;
        return "Levemente acima do peso";

      } else if ((imc < 35.0 && !this.gender) || (imc < 30.0 && this.gender)) {
        this.materializeColorScale = 600;
        return "Obesidade Grau I";

      } else if ((imc < 40.0 && !this.gender) || (imc < 40.0 && this.gender)) {
        this.materializeColorScale = 700;
        return "Obesidade Grau II";

      } else {
        this.materializeColorScale = 900;
        return "Obesidade Grau IIII";
      }
    }
  }
