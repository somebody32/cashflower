// Templates
var income_history_link_src  = '{{#cashflows}}{{#cashflow}}<li class="arrow"><span class="income_history"><a id="{{id}}" href="#">${{value}}</a></span></li>{{/cashflow}}{{/cashflows}}';
var outcome_history_link_src = '{{#cashflows}}{{#cashflow}}<<li class="arrow"><span class="outcome_history"><a id="{{id}}" href="#">${{value}}</a></span></li>{{/cashflow}}{{/cashflows}}';

var income_history_link  = Handlebars.compile(income_history_link_src);
var outcome_history_link = Handlebars.compile(outcome_history_link_src);

$(function() {

});
