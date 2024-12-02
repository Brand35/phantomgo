import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="board"
export default class extends Controller {
  static values = {
    id: String,
    color: String,
    intersection: String,
    userId: String,
    playerId: Boolean
  }

  connect() {
    console.log(this.playerIdValue);

    this.channel = createConsumer().subscriptions.create(
      {channel: "GameChannel", game_id: this.idValue, user_id: this.userIdValue},
      {received: (data) => {
        console.log(data)
      }}
    )
    // afficher les pierres déjà existantes d'après le board_state...
  }
 // il faut rajouter par desssu de ma cell une div qui represente le pions et
    // je dois fetch la route pour jouer du back end
    // patch "games/:id/play", to: "games#play"

  place(event){
    // console.log(this.intersectionValue);

    const intersectionCoordinates = event.currentTarget.dataset.intersection;

    fetch(`${this.idValue}/play`, {
      method: "PATCH", // Could be dynamic with Stimulus values
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ color: this.colorValue, coordinates: intersectionCoordinates })
     })
    //  .then(response => console.log(response.json()))
     .then(response => response.json())
    .then((data) => {
      location.reload()
    })

    // const templateName = (this.colorValue === "white") ? "stone-w" : "stone-b";
    // const stone = document.getElementById(templateName).innerHTML
    // const intersection = event.currentTarget
    // intersection.insertAdjacentHTML('beforeend', stone)
  }
}
