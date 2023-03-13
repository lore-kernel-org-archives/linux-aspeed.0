From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Mar 2023 22:41:34 +0100
Subject: [PATCH v2 25/25] drm/pl111: Use GEM DMA fbdev emulation
In-Reply-To: <20230313155138.20584-26-tzimmermann@suse.de>
References: <20230313155138.20584-1-tzimmermann@suse.de> <20230313155138.20584-26-tzimmermann@suse.de>
Message-ID: <CACRpkdYDpvpvURPCsdAMEd6s4_uU3UCpWoVLYkM8jh+wBM0ACg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 13, 2023 at 4:51?PM Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Use the fbdev emulation that is optimized for DMA helpers. Avoids
> possible shadow buffering and makes the code simpler.
>
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/dri-devel/CACRpkdawSQsNqKJkSSoSw3HmMHyNXFUywxkdszpTC-a_uZA+tQ at mail.gmail.com/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
