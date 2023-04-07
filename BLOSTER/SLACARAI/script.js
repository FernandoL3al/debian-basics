function Addc(){
    const localAdiconar = document.getElementById("time")
    const element = document.querySelector("p")

    const nome = document.getElementById("nome").value
    const posicao = document.getElementById("posicao").value
    const numero = document.getElementById("numero").value

    const newElement = document.createElement("p")
    newElement.innerText = numero + " " + posicao + " " + nome

    if(prompt("Deseja escalar o Jogador " + nome + "?(s/n) \n") === "s" ){
        element.appendChild(newElement)
        localAdiconar.appendChild(element)
    }
    
    document.getElementById("nome").value = ''
    document.getElementById("posicao").value = ''
    document.getElementById("numero").value = ''
}

function Remv(){

    const localRemover = document.getElementById("time")

    const numero = document.getElementById("numero").value

    const remover = document.querySelector('p > text:' + numero)

    localRemover.removeChild(remover)


}