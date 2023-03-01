From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 01 Mar 2023 14:54:50 +0800
Subject: [PATCH v4 5/5] dt-bindings: clock: ast2600: Add reset config
 for I3C
In-Reply-To: <CACPK8XfRg9vHYjC0rco4dr9pNY03vXTrmXaopOGBgdCq09LybQ@mail.gmail.com>
References: <20230228091638.206569-1-jk@codeconstruct.com.au>
	 <20230228091638.206569-6-jk@codeconstruct.com.au>
	 <CACPK8XcA_SES=Wo7vuWEJ4U5kTizM5brmb=6ELXD-taCFJQwgA@mail.gmail.com>
	 <cbbb99ce6125048667e4c41412710a61dc4d686f.camel@codeconstruct.com.au>
	 <CACPK8XfRg9vHYjC0rco4dr9pNY03vXTrmXaopOGBgdCq09LybQ@mail.gmail.com>
Message-ID: <51803a244c28c53b5adb384effc09df1909dd1e8.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> > So I'm not sure what that comment is supposed to signify as to what
> > qualifies as a "gate" in the context of a reset...
> 
> This is poor documentation from the author of the clock driver,

Hah, not that guy again!

> which is me.

oh.

> We only expose the reset lines in the device tree for resets that are
> not associated with a clock line.
> 
> This is done because the aspeed docs specify we do a dance when
> enabling an IP:
> 
> ?1. Place IP in reset
> ?2. Enable clock
> ?3. Delay
> ?4. Release reset
> 
> So we do this with the aspeed_g6_gates array. The rule is: any gate
> with a number in the rst column doesn't have that reset line exposed.
> That's what this cryptic comment in the header is warning about.

That makes sense, and means I can drop the explicit reset control from
the DTS, and then we don't need these definitions.

> This was documented to some extent in the original commit message for
> the 2400/2500 driver:
> 
> ?https://git.kernel.org/torvalds/c/15ed8ce5f84e2b
> 
> We could hoist that out and put it in the source file(s).

Awesome, thanks for the explanation - I'll add a patch to do so.

Cheers,


Jeremy
