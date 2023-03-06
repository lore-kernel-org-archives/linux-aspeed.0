From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 Mar 2023 23:19:08 +0100
Subject: [PATCH 20/22] drm/tve200: Use GEM DMA fbdev emulation
In-Reply-To: <20230301153101.4282-21-tzimmermann@suse.de>
References: <20230301153101.4282-1-tzimmermann@suse.de> <20230301153101.4282-21-tzimmermann@suse.de>
Message-ID: <CACRpkdYS54Svj=B-NfrjX+kBDYw5e9Jyt70L0tr_iX5+mVYK4A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 1, 2023 at 4:31?PM Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Use the fbdev emulation that is optimized for DMA helpers. Avoids
> possible shadow buffering and makes the code simpler.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

That sounds neat:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
