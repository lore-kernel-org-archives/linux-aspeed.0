From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 17:21:28 +0800
Subject: [RFC PATCH] dt-bindings: Add AST2600 i3c controller binding
In-Reply-To: <929a30fc-35f3-ab21-3a16-936ed69d5505@linaro.org>
References: <5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk@codeconstruct.com.au>
	 <7c6741e1-ae41-ba20-b859-736214c680e8@linaro.org>
	 <91e9e815bed8c2eff19dbe6b3ed36d10c6edcbfd.camel@codeconstruct.com.au>
	 <929a30fc-35f3-ab21-3a16-936ed69d5505@linaro.org>
Message-ID: <80fa21969d9e0e7a123bd525199dbb40e79d47e3.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

> You should clearly communicate that driver is coming...

OK.

> Anyway binding comes with the driver, otherwise how can we check that
> you actually implemented it?

I'll include this with the driver once we're past the RFC reviews.

> Please send patches, not RFC. RFC means you are uncertain this is even
> correct and you ask for generic discussion.

Yes, that's essentially what I'm looking for with this change -
particularly with the pullup config, which (as you say) could arguably
be a pinctrl config instead.

If we do decide to do this with pinctrl config, we'll need a separate
driver (and minimal binding) for the global register set to act as the pin
controller. That fundamentally changes the structure here - hence RFC.

> generic discussion comment - implement how other recent i3c bindings
> are implemented. This is basic device, there is nothing special here.

I'd say the global register set makes the binding layout a bit quirky,
as you've identified already.

> Since you did not respond to rest of comments, I assume you are going
> to implement them fully - including dropping the questioned
> properties.

Yep! Some of those will then be unneeded in this binding after going to a
pinctrl approach, and I'll make the fixes as you suggested.

Cheers,


Jeremy
