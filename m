From: Joel Stanley <joel@jms.id.au>
Date: Mon, 30 Jan 2023 22:57:01 +0000
Subject: [PATCH] pinctrl: aspeed: Revert "Force to disable the function's signal"
In-Reply-To: <CACRpkdY3VtkJZn4pHawFiW7yie+BWvT8o9Qx0Ym0ihgi3ACJ2A@mail.gmail.com>
References: <20230130220845.917985-1-joel@jms.id.au> <CACRpkdY3VtkJZn4pHawFiW7yie+BWvT8o9Qx0Ym0ihgi3ACJ2A@mail.gmail.com>
Message-ID: <CACPK8XdCjpmx7rQoR2dBCovC6B60m-ovdn91jA7DpgOfp-LiyA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 30 Jan 2023 at 22:52, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jan 30, 2023 at 11:09 PM Joel Stanley <joel@jms.id.au> wrote:
>
> > For now, revert the offending patch while a correct solution is found.
> >
> > Fixes: cf517fef601b ("pinctrl: aspeed: Force to disable the function's signal")
> > Link: https://github.com/openbmc/linux/issues/218
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Patch applied for fixes, sorry for not getting around to reverting it
> myself, but the commit message got really nice in the meantime :)

:D

Thank you!
