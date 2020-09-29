From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Sep 2020 14:42:22 +0200
Subject: [PATCH 4/4] pinctrl: aspeed-g5: Fix LPC register offsets
In-Reply-To: <20200911034631.8473-5-chiawei_wang@aspeedtech.com>
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
 <20200911034631.8473-5-chiawei_wang@aspeedtech.com>
Message-ID: <CACRpkdbn9294JnddMsmGooCe7KCxMiGbuAZ+OAuLwPkZUYD10A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2020 at 5:47 AM Chia-Wei, Wang
<chiawei_wang@aspeedtech.com> wrote:

> The LPC register offsets are fixed to adapt to the LPC DTS change,
> where the LPC partitioning is removed.
>
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

I can apply this one patch if I get a review from one of the
Aspeed pinctrl maintainer.

Andrew?

Yours,
Linus Walleij
