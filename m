From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 22:04:50 +0800
Subject: [RFC PATCH] dt-bindings: Add AST2600 i3c controller binding
In-Reply-To: <71aeb3da-13a1-1c79-9fe6-f5c23d398394@linaro.org>
References: <5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk@codeconstruct.com.au>
	 <7c6741e1-ae41-ba20-b859-736214c680e8@linaro.org>
	 <91e9e815bed8c2eff19dbe6b3ed36d10c6edcbfd.camel@codeconstruct.com.au>
	 <929a30fc-35f3-ab21-3a16-936ed69d5505@linaro.org>
	 <80fa21969d9e0e7a123bd525199dbb40e79d47e3.camel@codeconstruct.com.au>
	 <71aeb3da-13a1-1c79-9fe6-f5c23d398394@linaro.org>
Message-ID: <2528217bf1d43b834587cc0e399d7e86695bd390.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

> > Yes, that's essentially what I'm looking for with this change -
> > particularly with the pullup config, which (as you say) could
> > arguably
> > be a pinctrl config instead.
> 
> Depends, there was just a short sentence. If this is external
> resistor
> on the board, why this device needs such property (and none of other
> devices need...)? If this is internal pull up of I3C (and there is no
> other pin configuration possible, no other pins), it looks reasonable
> to me to have it here. But I am all guessing it...

It's the second case: there is a configurable pullup resistor in each of
the i3c controllers (or, more accurately: in the ast2600's glue
between the SoC and the I3C IP block).

The pullup configuration is controlled by the SoC "global" i3c
registers; a block shared by all of the SoC's i3c controllers. So, any
driver implementation would need to set up that global register
configuration on i3c controller init.

So, I can see two options for the binding (and consequently the driver
implementation):

 1) the sda-pullup-ohms property on the controller binding, which a
 driver implementation could set directly through the global register
 set

 2) define a pin controller on the global register block, allowing other
 (standard) DT pinctrl definitions to control the pullup calue. This
 would need a new driver implementation for the pin controller, but that
 shouldn't be too complex to implement.

For the binding proposed here, I've chosen (1). We can handle all of the
other (non-pullup-related) global register configuration by treating the
globals as a simple generic syscon device.

I'm happy to try (2) instead, if that's the better approach. However,
that may be over-engineering the binding spec (and consequently, the
necessary driver implementation) for just setting a register value.

From your second point:

> (and there is no other pin configuration possible, no other pins)

This is a fairly small and isolated component of the global ast2600 pin
configuration; the pullup value is set separately from the
already-implemented SoC-wide pinctrl. Merging the pullup values into
that wouldn't really fit the hardware interface mode though; this is a
separate IP block linked to the i3c controllers.

Let me know if you have any preferences on the approach to a biding
structure.

And Andrew: let me know if your experience with the ast2600 SoC's
pinctrl would suggest either option.

Cheers,


Jeremy
