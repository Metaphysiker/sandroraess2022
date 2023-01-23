function parseImportmapJson(){return JSON.parse(document.querySelector("script[type=importmap]").text).imports}function registerControllerFromPath(r,e,t){const o=r.replace(new RegExp(`^${e}/`),"").replace("_controller","").replace(/\//g,"--").replace(/_/g,"-");o in registeredControllers||import(r).then((r=>registerController(o,r,t))).catch((e=>console.error(`Failed to register controller: ${o} (${r})`,e)))}function lazyLoadExistingControllers(r,e,t){queryControllerNamesWithin(t).forEach((t=>loadController(t,r,e)))}function lazyLoadNewControllers(r,e,t){new MutationObserver((t=>{for(const{attributeName:o,target:l,type:n}of t)switch(n){case"attributes":o==controllerAttribute&&l.getAttribute(controllerAttribute)&&extractControllerNamesFrom(l).forEach((t=>loadController(t,r,e)));case"childList":lazyLoadExistingControllers(r,e,l)}})).observe(t,{attributeFilter:[controllerAttribute],subtree:!0,childList:!0})}function queryControllerNamesWithin(r){return Array.from(r.querySelectorAll(`[${controllerAttribute}]`)).map(extractControllerNamesFrom).flat()}function extractControllerNamesFrom(r){return r.getAttribute(controllerAttribute).split(/\s+/).filter((r=>r.length))}function loadController(r,e,t){r in registeredControllers||import(controllerFilename(r,e)).then((e=>registerController(r,e,t))).catch((e=>console.error(`Failed to autoload controller: ${r}`,e)))}function controllerFilename(r,e){return`${e}/${r.replace(/--/g,"/").replace(/-/g,"_")}_controller`}function registerController(r,e,t){r in registeredControllers||(t.register(r,e.default),registeredControllers[r]=!0)}import"@hotwired/stimulus";const controllerAttribute="data-controller",registeredControllers={};export function eagerLoadControllersFrom(r,e){Object.keys(parseImportmapJson()).filter((e=>e.match(new RegExp(`^${r}/.*_controller$`)))).forEach((t=>registerControllerFromPath(t,r,e)))}export function lazyLoadControllersFrom(r,e,t=document){lazyLoadExistingControllers(r,e,t),lazyLoadNewControllers(r,e,t)}