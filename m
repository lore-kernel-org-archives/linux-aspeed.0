From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 29 Jun 2018 09:53:11 +1000
Subject: [PATCH 4/4] gpio: aspeed: Add interfaces for co-processor to
 grab GPIOs
In-Reply-To: <CACRpkdYjUX4JtEW0+0Gxjfp5gSNKp8PM7CPY_nf=nQb=rfHRBQ@mail.gmail.com>
References: <20180612001043.9327-1-benh@kernel.crashing.org>
 <20180612001043.9327-5-benh@kernel.crashing.org>
 <CACRpkdbup=bx3rnZbWBMD_p2+8EHkY9Mxc2UEOwHzZE10=VeQA@mail.gmail.com>
 <480dd5a586acfaaeddcd099e3f1854f27fa44522.camel@kernel.crashing.org>
 <CACRpkdYjUX4JtEW0+0Gxjfp5gSNKp8PM7CPY_nf=nQb=rfHRBQ@mail.gmail.com>
Message-ID: <ac72e7cf162e9303dd46f218544e9b51e1b62281.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2018-06-28 at 15:42 +0200, Linus Walleij wrote:
> 
> Aha I see, you need that because while normally the gpiolib
> does the conversion of desc -> offset this is needed here
> in a driver.
> 
> Maybe we should just name it gpiod_to_offset() or something
> and make it a public API.
>
> But this is actually OK, you definately need it here, toss in some
> comment or so about what is going on and why this is included
> so we know in the future.

Ok, I'll spin a v4 with the interface addition I need to pass the
offsets to the coprocessor and will add that comment some time today.

Cheers,
Ben.

