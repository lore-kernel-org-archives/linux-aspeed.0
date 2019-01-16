From: Borislav Petkov <bp@alien8.de>
Date: Wed, 16 Jan 2019 22:30:59 +0100
Subject: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
In-Reply-To: <20190115175749.01E3C6E85603@corona.crabdance.com>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
 <20190110095049.GB17621@zn.tnic>
 <20190115175749.01E3C6E85603@corona.crabdance.com>
Message-ID: <20190116213059.GM15409@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 15, 2019 at 09:57:48AM -0800, Stefan Schaeckeler wrote:
> That's interesting. I did a grep over all 16944 GPL licensed files with an SPDX
> identifier.
> 
> 785 of them have a license text while 16159 don't.

Goes to show that we're still in the process of converting stuff to SPDX.

> When stripping off aspeed_edac_, some static function names will become quite
> "bare-bone":
> 
> aspeed_edac_init(), aspeed_edac_exit(), aspeed_edac_probe(),
> aspeed_edac_remove(), aspeed_edac_of_match(), aspeed_edac_isr(),
> aspeed_edac_config_irq().

So namespaced function names we normally use for globally visible
symbols and those are not but only driver-specific. So, for example,

aspeed_edac_config_irq()

is a mouthful, at least to me, and not needed. config_irq(), OTOH, is
clear at a very quick glance.

The others, aspeed_edac_init(), etc, you could call aspeed_init(),
aspeed_exit() or so.

But since you're going to be stare at that code, this was just a
suggestion. Your call. :)

> Does your suggestion also apply to static variables? E.g. aspeed_edac_regmap,
> aspeed_edac_regmap_config, aspeed_edac_driver? Also, here some variable names
> would become quite "bare-bone".

Same as above.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
