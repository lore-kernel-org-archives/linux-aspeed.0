From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 4 Mar 2023 22:53:02 +0100
Subject: [PATCH 11/22] drm/meson: Use GEM DMA fbdev emulation
In-Reply-To: <20230301153101.4282-12-tzimmermann@suse.de>
References: <20230301153101.4282-1-tzimmermann@suse.de> <20230301153101.4282-12-tzimmermann@suse.de>
Message-ID: <CAFBinCCV4yu1HszSaCJuNVMhDC35hA8cpzLMw1x=a3x+LNYrEw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 1, 2023 at 4:31?PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Use the fbdev emulation that is optimized for DMA helpers. Avoids
> possible shadow buffering and makes the code simpler.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
