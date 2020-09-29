From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Sep 2020 14:25:54 +0200
Subject: [PATCH 0/3] pinctrl: aspeed: AST2600 pinconf fixes
In-Reply-To: <20200909114312.2863675-1-andrew@aj.id.au>
References: <20200909114312.2863675-1-andrew@aj.id.au>
Message-ID: <CACRpkdaF7LaU_+4FrKGFYnKwLLe-iYkEzh4u3anv+16m6XUi4A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2020 at 1:43 PM Andrew Jeffery <andrew@aj.id.au> wrote:

> The AST2600 pinctrl driver was missing support for bias control on the 1.8V
> GPIO pins, and in the process of resolving that I discovered a couple of other
> bugs that are fixed in the first two patches of the series.

All 3 patches applied.

Yours,
Linus Walleij
