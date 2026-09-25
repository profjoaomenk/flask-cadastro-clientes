from flask import Flask, render_template, request

app = Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def index():
    mensagem = None

    if request.method == "POST":
        nome = request.form.get("nome", "").strip()

        # Os dados nao sao armazenados o formulario serve apenas para demonstracao
        if nome:
            mensagem = f"Formulario enviado! Cliente: {nome}"
        else:
            mensagem = "Formulario recebido!"

    return render_template("index.html", mensagem=mensagem)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
