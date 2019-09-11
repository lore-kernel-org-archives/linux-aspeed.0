From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2019 11:10:02 +0100
Subject: [PATCH v3 3/5] gpio/aspeed: Setup irqchip dynamically
In-Reply-To: <20190906062644.13445-1-rashmica.g@gmail.com>
References: <20190906062644.13445-1-rashmica.g@gmail.com>
Message-ID: <CACRpkda7WAZxUSjOXRj5Q1mSC0ZhYey2E9RkuX7p6Wcs_kXB=w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 6, 2019 at 7:26 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:

> This is in preparation for adding ast2600 support. The ast2600 SoC
> requires two instances of the GPIO driver as it has two GPIO
> controllers. Each instance needs it's own irqchip.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Patch applied with Joel's ACK, needed some fuzzing but
fixed it up.

Yours,
Linus Walleij
