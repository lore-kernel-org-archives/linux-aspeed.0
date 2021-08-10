From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Aug 2021 15:54:11 +0200
Subject: [RFC PATCH 4/6] leds: pca955x: Use pinctrl to map GPIOs to pins
In-Reply-To: <20210723075858.376378-5-andrew@aj.id.au>
References: <20210723075858.376378-1-andrew@aj.id.au>
 <20210723075858.376378-5-andrew@aj.id.au>
Message-ID: <CACRpkdZm9C23aHTWs8DNX1RChSB4A-X0PoyW5wnH2XyQQeviag@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 23, 2021 at 9:59 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> The leds-pca955x driver currently assumes that the GPIO numberspace and
> the pin numberspace are the same. This quickly falls apart with a
> devicetree binding such as the following:
(...)

Honestly I do not understand this patch. It seems to implement a pin
controller and using it in nonstandard ways.

If something implements the pin controller driver API it should be
used as such IMO, externally. This seems to be using it do relay
calls to itself which seems complicated, just invent something
locally in the driver in that case? No need to use pin control?

Can you explain why this LED driver needs to implement a pin
controller?

Yours,
Linus Walleij
