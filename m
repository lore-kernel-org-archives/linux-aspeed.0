From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Jul 2018 16:13:01 +0200
Subject: [PATCH v4 0/4] gpio: aspeed: Fixes and support for sharing with
 co-processor
In-Reply-To: <20180629041119.5132-1-benh@kernel.crashing.org>
References: <20180629041119.5132-1-benh@kernel.crashing.org>
Message-ID: <CACRpkda_Rx+MRS_QZRYjbFomPsAhO5t4ViipA3+uHoGMaJEfrw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 29, 2018 at 6:11 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> This series cleans up the register accessors a bit, adds missing ones,
> fixes the access to the write latch and finally adds an interface
> that a co-processor driver can use to change the owner of some of
> the GPIO lines and arbitrate access to shared GPIO banks.
>
> v2: - Address Joel comments
> v3: - Adds Reviewed-by tags
> v4: - Document the reason for including gpiolob.h
>     - Expose GPIO offsets & bit number so coprocessor firmware doesn't
>       have to hard-code them (allows multi-system generic firwmare
>       that gets "configure" by the copro driver)

I've applied the v4 to the "ib-apeed" driver and merged that for
devel, I will push to linux-next once the build servers confirm
they are happy as well.

The immutable branch is here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-aspeed

Yours,
Linus Walleij
