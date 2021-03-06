﻿/*
   jQuery (character and word) counter
   Copyright (C) 2009  Wilkins Fernandez

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/(function(b) { b.fn.extend({ counter: function(a) { a = b.extend({}, { type: "char", count: "down", goal: 140 }, a); var d = false; return this.each(function() { function e(c) { if (typeof a.type === "string") switch (a.type) { case "char": if (a.count === "down") { g = " character(s) left"; return a.goal - c } else if (a.count === "up") { g = " characters (" + a.goal + " max)"; return c } break; case "word": if (a.count === "down") { g = " word(s) left"; return a.goal - c } else if (a.count === "up") { g = " words (" + a.goal + " max)"; return c } break; default: } } var g, f = b(this); b('<div id="' + this.id + '_counter"><span>' + e(b(f).val().length) + "</span>" + g + "</div>").insertAfter(f); var i = b("#" + this.id + "_counter span"); f.bind("keyup click blur focus change paste", function(c) { switch (a.type) { case "char": c = b(f).val().length; break; case "word": c = f.val() === "" ? 0 : b.trim(f.val()).replace(/\s+/g, " ").split(" ").length; break; default: } switch (a.count) { case "up": if (e(c) >= a.goal && a.type === "char") { b(this).val(b(this).val().substring(0, a.goal)); d = true; break } if (e(c) === a.goal && a.type === "word") { d = true; break } else if (e(c) > a.goal && a.type === "word") { b(this).val(""); i.text("0"); d = true; break } break; case "down": if (e(c) <= 0 && a.type === "char") { b(this).val(b(this).val().substring(0, a.goal)); d = true; break } if (e(c) === 0 && a.type === "word") d = true; else if (e(c) < 0 && a.type === "word") { b(this).val(""); d = true; break } break; default: } f.keydown(function(h) { if (d) { this.focus(); if (h.keyCode !== 46 && h.keyCode !== 8) if (b(this).val().length > a.goal && a.type === "char") { b(this).val(b(this).val().substring(0, a.goal)); return false } else return h.keyCode !== 32 && h.keyCode !== 8 && a.type === "word" ? true : false; else { d = false; return true } } }); i.text(e(c)) }) }) } }) })(jQuery);