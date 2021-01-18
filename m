From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Jan 2021 15:59:16 +0100
Subject: [PATCH v5 4/5] pinctrl: aspeed-g5: Adapt to new LPC device tree
 layout
In-Reply-To: <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-5-chiawei_wang@aspeedtech.com>
Message-ID: <CACRpkdbqJuKHH+sR3LfWV72kM7TEhimFVi1viuQGkP8DWOODow@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 14, 2021 at 2:17 PM Chia-Wei, Wang
<chiawei_wang@aspeedtech.com> wrote:

> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
>
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I suppose the patches need to go in together. Tell me if you
need me to apply this one patch to the pinctrl tree.

Yours,
Linus Walleij
