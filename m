From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 24 Nov 2021 00:35:23 +0100
Subject: [PATCH/RFC 07/17] iio: st_sensors: Use bitfield helpers
In-Reply-To: <afb895b597037a635acc4a1dc44b88598268a19b.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <afb895b597037a635acc4a1dc44b88598268a19b.1637592133.git.geert+renesas@glider.be>
Message-ID: <CACRpkdZAA_XZQ7KXOsod8r5EZ0F9f1qaz3+FLsuyPfeD_mO5Dw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 22, 2021 at 4:55 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Use the field_prep() helper, instead of open-coding the same operation.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Clever!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
