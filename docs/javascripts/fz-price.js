// Live FocuZ price from the same Lemon Squeezy /pricing route the lokahi.shop homepage uses.
// Any element with data-fz-price="license" (or "update") keeps its static text (the fallback search
// engines and no-JS readers see) unless the route answers with a valid USD price.
(function () {
  var nodes = document.querySelectorAll("[data-fz-price]");
  if (!nodes.length) return;
  fetch("https://focuz-license-webhook.lokahi.workers.dev/pricing")
    .then(function (r) { return r.ok ? r.json() : null; })
    .then(function (p) {
      if (!p || !p.available || p.currency !== "USD") return;
      nodes.forEach(function (el) {
        var item = p[el.getAttribute("data-fz-price")];
        if (!item || typeof item.price !== "number" || item.price <= 0) return;
        var cents = item.price % 100;
        el.textContent = "$" + Math.floor(item.price / 100) + (cents ? "." + String(cents).padStart(2, "0") : "");
      });
    })
    .catch(function () { /* keep the static price */ });
})();
