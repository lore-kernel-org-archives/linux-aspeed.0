From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Jun 2021 12:16:27 +0200
Subject: [PATCH v2 1/4] dt-bindings: aspeed-sgpio: Convert txt bindings to
 yaml.
In-Reply-To: <20210531052318.GA3973@aspeedtech.com>
References: <20210527005455.25758-1-steven_lee@aspeedtech.com>
 <20210527005455.25758-2-steven_lee@aspeedtech.com>
 <CACRpkdZFcFuT9rdrc8BfEBmhy0--9uLMSJWfr=A+nU117_BT8A@mail.gmail.com>
 <20210528040934.GA28403@aspeedtech.com>
 <CACRpkdYnvzOW_86QgLAsNpNXWZXpaMiE7g9_jHZ0ZsFyhOjjAg@mail.gmail.com>
 <20210531052318.GA3973@aspeedtech.com>
Message-ID: <CACRpkdbq5me7erKdzaDHrPP5QjY4-Oxqz20tg2rSn3yrWDrhYQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 31, 2021 at 7:23 AM Steven Lee <steven_lee@aspeedtech.com> wrote:

> The parameter max-ngpios is the maxmum number of gpio pins that SoC supported,
> ngpios is the maximum number of gpio pins that sgpio devices(e.g. sgpio cards) supported.

When you put it like that you really make it sound like you already
know, just looking at the compatible string, what max-ngpios is?

I.e. do you know for these three:

aspeed,ast2400-sgpiom
aspeed,ast2500-sgpiom
aspeed,ast2600-sgpiom

the unique number of slots for each? A 1-to-1 correspondance?

Then just add code to set this value from looking at the compatible
in the driver. You can write some text in description in these bindings
about how many slots each SoC has but there is no need to add any
extra parameter if you already know this from the SoC.

Yours,
Linus Walleij
