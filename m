From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Mar 2023 22:48:16 +0100
Subject: [PATCH v2 03/16] gpio: aspeed: Convert to immutable irq_chip
In-Reply-To: <861qlzz89j.wl-maz@kernel.org>
References: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
 <20230215-immutable-chips-v2-3-d6b0e3f2d991@linaro.org> <CACPK8Xc7ekzM9oeR7+fYuK8RfZ4jA8gpH=nUJ-OTp0XZoKwzHQ@mail.gmail.com>
 <861qlzz89j.wl-maz@kernel.org>
Message-ID: <CACRpkdZ_jEd5hZDGaTd+4Ns7o+oMiAh=pED==WemVCnC-csNqg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 8, 2023 at 2:23?PM Marc Zyngier <maz@kernel.org> wrote:

> > >                 girq->chip->name = dev_name(&pdev->dev);
>
> And this assignment will probably explode if, as expected, 'chip' is
> const and cannot be written to.
>
> I obviously didn't spot this when I first looked at these patches.

Dang, I'll fix, then I will go over the rest of the patches
and make sure I didn't miss any other of these name assignments.

Thanks,
Linus Walleij
