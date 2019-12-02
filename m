From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 2 Dec 2019 12:04:42 +0000
Subject: [PATCH v3 0/6] DA9062 PMIC features
In-Reply-To: <CACRpkdaSmwORgetv7aZjtgk+2OchcvQR4SBjdWQ4KsRMHuUvSg@mail.gmail.com>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <CACRpkdaSmwORgetv7aZjtgk+2OchcvQR4SBjdWQ4KsRMHuUvSg@mail.gmail.com>
Message-ID: <20191202120442.GC14416@dell>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 02 Dec 2019, Linus Walleij wrote:

> On Fri, Nov 29, 2019 at 6:25 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > this series address all comments made on [1]. Patch "gpio: add support
> > to get local gpio number" is splitted into:
> >  - "gpio: treewide rename gpio_chip_hwgpio to gpiod_to_offset"
> >  - "gpio: make gpiod_to_offset() available for other users"
> > Please check the discussion [1] for more information. You need to apply
> > [2] to test the new features.
> 
> I am very happy with the shape of patches (1) and (2).
> 
> I can apply these on an immutable branch and merge into the
> GPIO tree at v5.5-rc1 and offer to other subsystem maintainers
> to pull in so they can merge the rest of the patch series on
> top.
> 
> Alternatively I can merge all the patches into the GPIO tree.
> 
> I suppose this is not so much of a MFD business at this
> point so whatever the regulator maintainer prefers I suppose?

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
