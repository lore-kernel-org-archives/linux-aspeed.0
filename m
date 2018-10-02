From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Oct 2018 09:35:02 +0200
Subject: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
In-Reply-To: <20181002041437.2493192-1-taoren@fb.com>
References: <20181002041437.2493192-1-taoren@fb.com>
Message-ID: <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tao, thanks for your patch!

On Tue, Oct 2, 2018 at 6:14 AM Tao Ren <taoren@fb.com> wrote:

> -       if (fttmr010->count_down)
> +       if (fttmr010->count_down) {
>                 writel(~0, fttmr010->base + TIMER1_LOAD);

This struct member "count_down" is a bit badly named now don't
you think?

The patch is fine semantically, but please rename this member
"is_aspeed" or something like that and update the code everywhere,
then insert a comments like

/* The Aspeed variant counts downward */
/* The Aspeed variant does not have a match interrupt */

in the code snippets so we see what is going on.

Yours,
Linus Walleij
