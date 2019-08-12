From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 12 Aug 2019 10:21:55 +0930
Subject: =?UTF-8?Q?Re:_[PATCH]_pinctrl:_aspeed:_g6:_Remove_const_specifier_from_a?=
 =?UTF-8?Q?speed=5Fg6=5Fsig=5Fexpr=5Fset's_ctx_parameter?=
In-Reply-To: <CACRpkdbDgOQXfxgM4dEyzBRhtske3=V+858B7J8jGExnJE5fJQ@mail.gmail.com>
References: <20190807003037.48457-1-natechancellor@gmail.com>
 <CACRpkdbDgOQXfxgM4dEyzBRhtske3=V+858B7J8jGExnJE5fJQ@mail.gmail.com>
Message-ID: <e5aa4940-41d8-4c35-9783-09548e406885@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 10 Aug 2019, at 17:43, Linus Walleij wrote:
> On Wed, Aug 7, 2019 at 2:32 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> 
> > clang errors:
> >
> > drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c:2325:9: error: incompatible
> > pointer types initializing 'int (*)(struct aspeed_pinmux_data *, const
> > struct aspeed_sig_expr *, bool)' with an expression of type 'int (const
> > struct aspeed_pinmux_data *, const struct aspeed_sig_expr *, bool)'
> > [-Werror,-Wincompatible-pointer-types]
> >         .set = aspeed_g6_sig_expr_set,
> >                ^~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> >
> > Commit 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
> > changed the set function pointer declaration and the g6 one wasn't
> > updated (I assume because it wasn't merged yet).
> >
> > Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/632
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Patch applied with Andrew's ACK.

FYI this fixes pinctrl/for-next which is likely where Nathan ran into the issue,
however to fix pinctrl/devel we'll need a back-merge of pinctrl/fixes, or to
apply 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps") to
pinctrl/devel also.

Fixing that bug was unfortunate timing wrt the 2600 driver.

Andrew
