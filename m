From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2019 10:40:02 +0200
Subject: [PATCH v2 0/8] pinctrl: aspeed: Preparation for AST2600
In-Reply-To: <20190628023838.15426-1-andrew@aj.id.au>
References: <20190628023838.15426-1-andrew@aj.id.au>
Message-ID: <CACRpkdaxiFR3ezt4FzhRxpqc4DYYjsbBeysPUaaQH+_QgYjudw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Fri, Jun 28, 2019 at 4:39 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello!
>
> The ASPEED AST2600 is in the pipeline, and we have enough information to start
> preparing to upstream support for it. This series lays some ground work;
> splitting the bindings and dicing the implementation up a little further to
> facilitate differences between the 2600 and previous SoC generations.
>
> v2 addresses Rob's comments on the bindings conversion patches. v1 can be found
> here:

I have applied this series, I had to strip some changes of the header
because it was based on some SPDX cleanups upstream but no
big deal I think. Check the result please.

Yours,
Linus Walleij
