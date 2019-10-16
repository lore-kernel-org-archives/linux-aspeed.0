From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2019 13:19:01 +0200
Subject: [PATCH 0/7] pinctrl: Fixes for AST2600 support
In-Reply-To: <20191008044153.12734-1-andrew@aj.id.au>
References: <20191008044153.12734-1-andrew@aj.id.au>
Message-ID: <CACRpkda5cWaA7R3XzyiERCCgwUrjnXd+wCBeKvt-wtjex7wNDg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 8, 2019 at 6:41 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> This series resolves several issues found in testing by Johnny Huang from
> ASPEED, who also contributed the patches to fix them. We'll have more patches
> from him in the near future (which I'm pretty happy about).
>
> The major issue resolved is the way I grouped the eMMC pins. What I had was
> ugly and I want to get rid of it before the binding is solidified with the 5.4
> release.

Should some of these go in with fixes? All of them? Or just some?
I applied them to devel right now (for v5.5).

> The remaining fixes are minor issues that stem from lack of documentation or
> understanding on my part, and at least one brain-fart.

Do they need to go in to v5.4 or not?

I need a shortlist of anything that should go into v5.4 if anything.

Yours,
Linus Walleij
