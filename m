From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Aug 2021 09:49:05 +0930
Subject: [RFC PATCH 4/6] leds: pca955x: Use pinctrl to map GPIOs to pins
In-Reply-To: <CACRpkdZm9C23aHTWs8DNX1RChSB4A-X0PoyW5wnH2XyQQeviag@mail.gmail.com>
References: <20210723075858.376378-1-andrew@aj.id.au>
 <20210723075858.376378-5-andrew@aj.id.au>
 <CACRpkdZm9C23aHTWs8DNX1RChSB4A-X0PoyW5wnH2XyQQeviag@mail.gmail.com>
Message-ID: <96e52916-f113-4a91-b83f-e0de144611ca@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 10 Aug 2021, at 23:24, Linus Walleij wrote:
> On Fri, Jul 23, 2021 at 9:59 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > The leds-pca955x driver currently assumes that the GPIO numberspace and
> > the pin numberspace are the same. This quickly falls apart with a
> > devicetree binding such as the following:
> (...)
> 
> Honestly I do not understand this patch. It seems to implement a pin
> controller and using it in nonstandard ways.

Yeah, it's a bit abusive, hence RFC :)

> 
> If something implements the pin controller driver API it should be
> used as such IMO, externally. This seems to be using it do relay
> calls to itself which seems complicated, just invent something
> locally in the driver in that case? No need to use pin control?

Right. After discussions with Andy I'm going to rework the approach to 
GPIOs which will remove a lot of complexity.

The thought was to try to maintain the intent of the devicetree binding 
and use existing APIs, but all-in-all it's ended up twisting things up 
in knots a fair bit. We discard a lot of it by making the gpiochip 
always cover all pins and track use directly in the driver.

> 
> Can you explain why this LED driver needs to implement a pin
> controller?

The short answer is it doesn't as it has none of the associated 
hardware.

I'll cook up something simpler with the aim to avoid non-standard (or 
any) pinctrl.

Andrew
