From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Oct 2023 14:01:58 +0200
Subject: [PATCH v2] pinctrl: aspeed: Allow changing SPI mode from hardware
 strap defaults
In-Reply-To: <20231005030849.11352-2-zev@bewilderbeest.net>
References: <20231005030849.11352-2-zev@bewilderbeest.net>
Message-ID: <CACRpkdZDBmUMY7pVxtSkVQnm9bHp+ObfmumO39j=XYeDJaD7Dw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 5, 2023 at 5:09?AM Zev Weiss <zev@bewilderbeest.net> wrote:


> Some platforms unfortunately have their SPI mode selection bits
> strapped incorrectly (such as being configured for passthrough mode
> when master mode is in fact the only useful configuration for it) and
> thus require correction in software.  Add the SPI mode bits to the
> GPIO passthrough bits as the exceptions to the read-only rule for the
> hardware strap register so that the pinctrl subsystem can be used for
> such corrections.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Patch applied!

Yours,
Linus Walleij
