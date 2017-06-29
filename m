From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Jun 2017 14:53:41 +0200
Subject: [PATCH 0/4] pinctrl: Add USB support for Aspeed SoCs
In-Reply-To: <20170627021214.23323-1-andrew@aj.id.au>
References: <20170627021214.23323-1-andrew@aj.id.au>
Message-ID: <CACRpkdZpJuaedE=04we_bcLB7qzOdvJAz4QmTfnuZA=5PrMf0g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 27, 2017 at 4:12 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> With recent interest in the USB virtual hub in the Aspeed SoCs[1] it is a good
> time to add pinmux support for the USB ports and controllers. The earlier
> series of pinmux patches for the Aspeed SoCs focussed on supporting pins which
> were capable of GPIO. This is not the case for the USB pins, hence they have
> been unsupported until now.
>
> Rob: I know you've mentioned previously you desired complete bindings to be
> provided up front, so apologies for continuing to add functionality. This looks
> to be the last of it.

Waiting for DT review and addressing of Beji's comment for these.

Please resend after the merge window.

Yours,
Linus Walleij
