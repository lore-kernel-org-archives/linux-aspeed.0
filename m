From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Sep 2020 14:39:10 +0200
Subject: [PATCH v2 0/3] pinctrl: aspeed: AST2600 pinconf fixes
In-Reply-To: <20200910025631.2996342-1-andrew@aj.id.au>
References: <20200910025631.2996342-1-andrew@aj.id.au>
Message-ID: <CACRpkdaqtcPsinURk88GFYyPcDr2SdoRXWUCHMMn2cQtbBYyog@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 10, 2020 at 4:57 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> The AST2600 pinctrl driver was missing support for bias control on the 1.8V
> GPIO pins, and in the process of resolving that I discovered a couple of other
> bugs that are fixed in the first two patches of the series.
>
> v2 Tweaks some of the debug output and adds Joel's Reviewed-by tags.

Applied this v2 instead of v1.

Thanks!
Linus Walleij
