import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "icon"]

  connect() {
    // 初期状態は閉じた状態にする
    this.isExpanded = false
    this.contentTarget.style.maxHeight = "0px"
  }

  toggle() {
    if (this.isExpanded) {
      // 閉じる
      this.contentTarget.style.maxHeight = "0px"
      this.iconTarget.style.transform = "rotate(-90deg)"
      this.isExpanded = false
    } else {
      // 開く
      this.contentTarget.style.maxHeight = "9999px"
      this.iconTarget.style.transform = "rotate(0deg)"
      this.isExpanded = true
    }
  }
}