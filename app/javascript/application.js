// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import jquery from "jquery"
window.$ = jquery
window.jQuery = jquery

import * as echarts from "echarts";
// import "echarts/theme/dark";

window.echarts = echarts;
