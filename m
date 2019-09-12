From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 12 Sep 2019 19:56:05 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_pinctrl/fixes]_pinctrl:_aspeed:_Fix_spurious_mux_fa?=
 =?UTF-8?Q?ilures_on_the_AST2500?=
In-Reply-To: <CACRpkdYW_PX7npB+b1YJ4pfFQNLVOsMx2hpKtntBeHg=C1j-Cg@mail.gmail.com>
References: <20190829071738.2523-1-andrew@aj.id.au>
 <CACRpkdYW_PX7npB+b1YJ4pfFQNLVOsMx2hpKtntBeHg=C1j-Cg@mail.gmail.com>
Message-ID: <c51f0ef0-cd1a-47db-8551-706c5864e0be@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 12 Sep 2019, at 17:53, Linus Walleij wrote:
> On Thu, Aug 29, 2019 at 8:17 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > Commit 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
> > was determined to be a partial fix to the problem of acquiring the LPC
> > Host Controller and GFX regmaps: The AST2500 pin controller may need to
> > fetch syscon regmaps during expression evaluation as well as when
> > setting mux state. For example, this case is hit by attempting to export
> > pins exposing the LPC Host Controller as GPIOs.
> >
> > An optional eval() hook is added to the Aspeed pinmux operation struct
> > and called from aspeed_sig_expr_eval() if the pointer is set by the
> > SoC-specific driver. This enables the AST2500 to perform the custom
> > action of acquiring its regmap dependencies as required.
> >
> > John Wang tested the fix on an Inspur FP5280G2 machine (AST2500-based)
> > where the issue was found, and I've booted the fix on Witherspoon
> > (AST2500) and Palmetto (AST2400) machines, and poked at relevant pins
> > under QEMU by forcing mux configurations via devmem before exporting
> > GPIOs to exercise the driver.
> >
> > Fixes: 7d29ed88acbb ("pinctrl: aspeed: Read and write bits in LPC and GFX controllers")
> > Fixes: 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
> > Reported-by: John Wang <wangzqbj@inspur.com>
> > Tested-by: John Wang <wangzqbj@inspur.com>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Applied for fixes already yesterday!

Thanks! Hoping to avoid such late fixes in the future...

Andrew
