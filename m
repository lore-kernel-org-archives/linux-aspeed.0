From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Nov 2020 15:34:59 +0100
Subject: [PATCH v2] pinctrl: aspeed: Fix GPI only function problem.
In-Reply-To: <20201030055450.29613-1-billy_tsai@aspeedtech.com>
References: <20201027084417.10137-1-billy_tsai@aspeedtech.com>
 <20201030055450.29613-1-billy_tsai@aspeedtech.com>
Message-ID: <CACRpkdY+oOWoEVEn8ECckYkUcDUJw2Ts4JMAu0bCbVxs3WNvZg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 30, 2020 at 6:55 AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Some gpio pin at aspeed soc is input only and the prefix name of these
> pin is "GPI" only.
> This patch fine-tune the condition of GPIO check from "GPIO" to "GPI"
> and it will fix the usage error of banks D and E in the AST2400/AST2500
> and banks T and U in the AST2600.
>
> Fixes: 4d3d0e4272d8 ("pinctrl: Add core support for Aspeed SoCs")
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Thanks Billy, patch applied for fixes!

Yours,
Linus Walleij
