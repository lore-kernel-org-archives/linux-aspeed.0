From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Jun 2018 16:13:49 +0200
Subject: [PATCH] pinctrl: aspeed: Fix documentation
In-Reply-To: <20180618124506.12961-1-joel@jms.id.au>
References: <20180618124506.12961-1-joel@jms.id.au>
Message-ID: <CACRpkdZphdiRXwkBpB58ikWf0YZKt8g-T_c9T52852FGNuPJFA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 18, 2018 at 2:45 PM Joel Stanley <joel@jms.id.au> wrote:

> Fixes these warnings:
>
>   pinctrl-aspeed.c:112: warning: Function parameter or member 'map' not
>   described in 'aspeed_sig_desc_eval'
>   pinctrl-aspeed.c:112: warning: Excess function parameter 'regmap'
>   description in 'aspeed_sig_desc_eval'
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Patch applied with Andrew's ACK.

Yours,
Linus Walleij
