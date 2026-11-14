Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8B606A330
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Nov 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=an/shuiN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRZXZ3NhPz3dW6;
	Sun, 15 Nov 2026 00:21:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794662510;
	cv=pass; b=mQikDroFu0W/IHSyv9NuOrcW+slsNPdZUF2zYkvEDdapXYvVyqzHzigUtK/ijcl1Rxd0w1bIxGzRqqCz2Z9ncE61hVYaCMf5GF6U/rBySY+ao0E+bVcm83tgzHHWWCSZlDZTyGeTLGxgO6s93a2CUecTwT8w/38/2ZDOLma/+L90Kk4nbhdhX2UdddzAgMK3ERIzYJ9fUr9sVOapA8DBJ174ZuyUrupA7tf3HCT7tkr+Mq1HW9wl4kTVBuY7KSJQx4Ccpe5cG2Htz76ljq+BWrtyMKSGTF0mocj+WJHNTpg9SNjjuw/BCEVH/j0FyWj1r0z+aC1Y9A7rYt5PzLrVvw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794662510; c=relaxed/relaxed;
	bh=KmDx6U5+aB6NguJULNw+IbB2BgxvC/BPaH6qaeSGzC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2Ck+oOqX2Rlr9HheBnEfB08As0sSxXXLRShdGwAdHhFENr1M343kjkmCZauXs8H3EAPborOQijeWG+37Y4tBFqTWBgqHYKd7Ku29QS83KUifiv/GjNVd/TcedxOqSGsczG4jbPwK1gVI6B0YVdVTX3Dq88y9yzbbSibnO/4uzxTRay1EzPvuw2kboO30picIp3lDMznqcoV4YXEAuo0sYwuKqWp/PwTCAKtZK0x4u/sDr4dwW9BMeLHDY0z0zs582QcbaFAXSV9kxnqLXoFP/aCltH1WWl7dNizd6uNvU6DkYJ8qP/4vjg2oBAyDT8zoZtSq5ch50L4aBx2NW/KvA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=an/shuiN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=an/shuiN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com [IPv6:2607:f8b0:4864:20::b12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRZXW6Bt4z3c7M
	for <linux-aspeed@lists.ozlabs.org>; Sun, 15 Nov 2026 00:21:47 +1100 (AEDT)
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-67bee1f693bso1614250d50.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Nov 2026 05:21:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794662505; cv=none;
        d=google.com; s=arc-20260327;
        b=NwD3QBj9C6ILq8PHDeyUNVDktU6fkSeaMb7LCDq6tfntvgQo35YjvTfU7VYt8xX8+G
         j+2HNt+Xfm0lgzNs8uXmQvSZ6Ewn5kyt9/bZmoe6CLAtBGM/FVAHSAjZXe3zkl3QUsX0
         NCXAhbLzJgExBeDjiD7o/dmfTtYnlWEjASTYJKOuDMUDpSnipbPr2URqNqFrNvbMGhdj
         1nx2HVnsWIuTAhTgolTC8pzh8OAaA2lBRVuN0RnhQ/WTk7XZnNiQ+NWFnzatbDTEPLmu
         ikAIno54zmdMWzjdbWKjadhtNQEzim/h6ybX4QmFbvh8KF/ZeqToyxT5G/7WvAVTYL3M
         HNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KmDx6U5+aB6NguJULNw+IbB2BgxvC/BPaH6qaeSGzC4=;
        fh=I6023Y4GdyT+LTay1QuFG4sdGaTEbyN3eZRymuAS4HE=;
        b=OLAjdIXjqJ+akEFXO4wQgIb46DiKF9vvASFksne7nyaXO9pTvW9OsIf/kvpzSSsLlk
         5/2zB+v1S9XZCX+Xj7g2zAO9gQZudYimC5OOu/f2qBmyNpY2TKy1GtRBU1Gt8TfKmDY2
         /vDO9rGO2lBsoAIJN5DAjfu7fqO3DeD2aOx/wJrfvmOeVY4U7JpGa8Woe4sGDo0lvOhu
         2YIrPhqMqshlfr5ME6p3JshmgJla0exHqc4FgKkYPCUeA6seun8Mc6ITdHTzplNPmvnu
         ElFox4KxeGtQDhjK+0TSPzwBasJ+OrPPpKBYoOYEvyju18K+PfntCMfWxUAc3nOVOGhS
         E+jQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794662505; x=1795267305; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KmDx6U5+aB6NguJULNw+IbB2BgxvC/BPaH6qaeSGzC4=;
        b=an/shuiN/mhHKdE7FYakyc1Kn6zOgy7taGe/H8w2G8o7vKw1Sz0rifBr0hTkrjsNHW
         uIMFo3fG/UBL0jePJU1Zsg2ZB23/Jj4Xloy754qJnJNleLJOHLGYJNDn665h5FcO58yt
         xwmzFwWnyM1lrxZaY3m6IDADmuFRs+73PjkBPUpT7RMekON/FXwxJYSj0sOXabs6m0uM
         sjO+NDxgQPXvbJCpD/kNo6vDy+9o6aDHqfBPc4vN4fNDc4czoJ6ICAG1znaRSJOMLiCE
         54EeHzlUeQp282CSWlxiIVPmww5OG9zhVmeiHp7pcrKdbUwQLFXJoxmGRKdVy6kccQMK
         15lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662505; x=1795267305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmDx6U5+aB6NguJULNw+IbB2BgxvC/BPaH6qaeSGzC4=;
        b=kxQ8K/cS1yH0koTt+G3llwqQaK2xLxc+KnW36aYBQRaS3Kqw8xmXReOylHO3hbi9Pc
         YWbEIoxQcO2hvFoGUNr5FaLg7FJYzzbByN/wkIDuycLmv3cL4qy2kdmnr8EhVjE2GepQ
         YW/VLNYF3JqrXIXYvKk0CLT5ykCaqpZ0D1IK4mklbX6j87Sc+nAkVpkYV3FcayokkvTr
         /eJf0hvGEjs2TP9Tora6fCf8lKYa6ac/5GxZVImT6gZdWCWdrEnLkeaJ0XbsL4zzAGNG
         Y12ed8zdIn+k5Wc6alCZb2BywBWn4ZbynDZh41ahWsBooUY/9ZdVVcFbOa1Y+Z2Oo3I3
         XGAg==
X-Forwarded-Encrypted: i=1; AL+hErEEo0twlUHtSVJNSXfOQQyskKMjeSF6Ji3sZLDiOFUBCKFYbAitGtWzsX9+XjdmRy4ChGeWHVN4Gx88xBI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+v7FQT+u9ztYUM9ikRqR1MDGLXE2vDJ2KMuuE0ZijfrVxcNzXX
	FCZWJG7KrSVUpAsdyL9qgfeBXpK7qKzDaZBuZoHAihbuUTIpDbBa0IuJuVl5Gty+4tKEAjXd9qf
	BM2JLVa/jL9X+mf2f8M4PshCEwkfjsDA=
X-Gm-Gg: AYBFou2xVY7U7nZT3hiyawAY14gi+a7W7zPP4Cfp0z3a7FKFai20l8U0QinKBNxk1+U
	0T+nBeM+TmGfUut27d/jHHFW9ZXH5I1Iykf1qOED8XQZ3z6w16yESgR3JXt9G9xiWK6Vkk7w00s
	k0obPzvhzJpt74xCiUh/qA6bMZcPoh+jT/Jpfrqce/XHlMzATr0KNtzNwhuVILjpj1GAPcQ//l4
	X41SG/HyHZv1eYXEFngolm99PMttomUA4TmA+UTUxk58xalkdffYkCnFaeKdMmFEWCge9uiyu2j
	xtoYtgRx3xNM+IeM4Rp4iz0lQ+PGZwQmvkTSgBMOOFDxU7ko/ih533dQgrAGNaN8xyeuHHLiFkA
	2RTmoL1JxI/TPR+bq8cjsFudC5nRu+f2fixlDbA==
X-Received: by 2002:a05:690e:4186:b0:679:9b73:bfaa with SMTP id
 956f58d0204a3-67d896a4118mr3259172d50.35.1794662504580; Sat, 14 Nov 2026
 05:21:44 -0800 (PST)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113034213.158390-1-prasanth.padarthi10@gmail.com>
 <20261113034213.158390-2-prasanth.padarthi10@gmail.com> <c6c39058-ebb2-433a-ab0e-5e35f5ccae24@9elements.com>
In-Reply-To: <c6c39058-ebb2-433a-ab0e-5e35f5ccae24@9elements.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Sat, 14 Nov 2026 18:51:33 +0530
X-Gm-Features: AclHuK-FBB5fFc4DfRzJ7P3nSgE9AFp8MWyKWEQCRTCQCeEWO5BzkBKMu-5J_dE
Message-ID: <CAMFFDGgowje2Vky0zXJ=2r+jmgp8WbsznPRE6ZNONBVoYx74tg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] nvmem: aspeed: Add read-only AST2600 OTP support
To: Tan Siewert <tan.siewert@9elements.com>
Cc: srini@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com, neal_liu@aspeedtech.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tan,

Thank you for the review. I am preparing v2 with these MOdifications:
- Renamed the driver to nvmem-aspeed-otp.c; updated Kconfig, headers,
and attribution comments.
- Used GENMASK(2, 1) and read_poll_timeout() with an initial delay.
- Reused read_pair() for CONF0 and removed its redundant bounds check.
- Moved secure-prefix initialization into probe and registered an NVMEM kee=
pout.
- Simplified word copying using put_unaligned_le32() to preserve byte
order and support unaligned buffers.
- Added scoped mutex locking, devm_mutex_init(), and the probe cleanups.
- Added timeout error logging and clarified the SEC00 completion-flush read=
back.
- Prepared the NVMEM binding update as a separate patch.
I also tested the updated driver on the B650D4U, AST2600 A3, running
Linux 7.4-rc1, base commit 6628e7d4c. The test used the working board
DTB and OpenBMC initramfs, with temporary diagnostics enabled.

The provider registered successfully. A 12-byte read at offsets
8172=E2=80=938183, covering an odd starting word and a pair boundary,
completed successfully and matched the saved vendor-derived reference.

I have requested ASPEED clarification separately on double completion
polling, timeout recovery/value, mode-register initialization, and
SEC54 interpretation. These decisions remain pending; the current 100
ms timeout is an engineering choice.

I will finalize v2 after resolving those points and validating the
code without temporary diagnostics.

Thanks,
Prasanth Kumar Padarthi

On Fri, Nov 13, 2026 at 6:35=E2=80=AFPM Tan Siewert <tan.siewert@9elements.=
com> wrote:
>
> On 11/13/26 4:42 AM, Prasanth Kumar Padarthi wrote:
> > Expose permitted AST2600 OTP data through NVMEM using the existing SBC
> > node. Serialize controller transactions, bound completion polling and
> > reject reads into the configured secure prefix.
>
> This only repeats what the code does. Please explain *why*. Who uses the
> data and which cells?
>
> >
> > Adapt the read sequence from ASPEED's downstream driver, preserving its
> > attribution. Register the driver for ASPEED review and restrict raw OTP
> > access to root.
>
> If you mean the MAINTAINERS hunk, just say so.
>
> >
> > Link: https://github.com/AspeedTech-BMC/linux/blob/769f62b7baa84d699872=
3b0ea60280e380183553/drivers/soc/aspeed/ast2600-otp.c
>
> No DCO Sign-off (neither from you nor Neal). And given that you've used
> the downstream driver as base it'd be cool if you can keep Neal as
> Co-developed-by in (with Neal's agreement).
>
> > ---
> > Tested on ASRock Rack B650D4U, AST2600 A3, OpenBMC Linux 6.18.24:
>
> Please test against the base commit you've used (i.e. 7.4-rc3). Using a
> vendor / OpenBMC tree here is not useful at all.
>
> > - Repeated, paired and cross-pair reads matched.
> > - Four concurrent readers completed 40 matching reads.
> > - Bytes 8172..8183 matched a separate vendor-derived reader.
> > - Synthetic pre-MMIO timeout, failure latching and rebind recovery pass=
ed.
> > Host fault-injection tests passed all 42 polling-timeout cases.
> >
> >   MAINTAINERS                 |   1 +
> >   drivers/nvmem/Kconfig       |  12 ++
> >   drivers/nvmem/Makefile      |   1 +
> >   drivers/nvmem/ast2600-otp.c | 259 +++++++++++++++++++++++++++++++++++=
+
> >   4 files changed, 273 insertions(+)
> >   create mode 100644 drivers/nvmem/ast2600-otp.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 93abbb3..c92ea8e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2813,6 +2813,7 @@ F:      Documentation/devicetree/bindings/arm/asp=
eed/
> >   F:  arch/arm/boot/dts/aspeed/
> >   F:  arch/arm/mach-aspeed/
> >   F:  arch/arm64/boot/dts/aspeed/
> > +F:   drivers/nvmem/ast2600-otp.c
> >   N:  aspeed
> >
> >   ARM/AXIADO ARCHITECTURE
> > diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> > index d2f5bb2..cdcd071 100644
> > --- a/drivers/nvmem/Kconfig
> > +++ b/drivers/nvmem/Kconfig
> > @@ -164,6 +164,18 @@ config NVMEM_APPLE_SPMI
> >         This driver can also be built as a module. If so, the module
> >         will be called apple-nvmem-spmi.
> >
> > +config NVMEM_ASPEED_AST2600_OTP
> > +     tristate "ASPEED AST2600 OTP support"
> > +     depends on ARCH_ASPEED || COMPILE_TEST
> > +     depends on HAS_IOMEM
> > +     help
> > +       Read-only access to the AST2600 OTP data region. The configured
> > +       secure prefix is not exposed. Fuse programming is not supported=
.
> > +       The controller reads paired 32-bit words through command regist=
ers.
>
> This is implementation-specific and doesn't help whether to enable the
> option. Drop.
>
> > +       Access to raw OTP data is restricted to root.
> > +
> > +       If built as a module, the module will be called ast2600-otp.
> > +
>
> "If unsure, select N"?
>
> >   config NVMEM_BCM_OCOTP
> >       tristate "Broadcom On-Chip OTP Controller support"
> >       depends on ARCH_BCM_IPROC || COMPILE_TEST
> > diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> > index 5e70bad..9fac69d 100644
> > --- a/drivers/nvmem/Makefile
> > +++ b/drivers/nvmem/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_NVMEM_APPLE_EFUSES)    +=3D nvmem-apple-=
efuses.o
> >   nvmem-apple-efuses-y                        :=3D apple-efuses.o
> >   obj-$(CONFIG_NVMEM_APPLE_SPMI)              +=3D apple_nvmem_spmi.o
> >   apple_nvmem_spmi-y                  :=3D apple-spmi-nvmem.o
> > +obj-$(CONFIG_NVMEM_ASPEED_AST2600_OTP)       +=3D ast2600-otp.o
>
> Maybe call the file "nvmem-aspeed-otp" or so? Would be nice if we can
> extend the driver for AST2700 support later on.
>
> >   obj-$(CONFIG_NVMEM_BCM_OCOTP)               +=3D nvmem-bcm-ocotp.o
> >   nvmem-bcm-ocotp-y                   :=3D bcm-ocotp.o
> >   obj-$(CONFIG_NVMEM_BRCM_NVRAM)              +=3D nvmem_brcm_nvram.o
> > diff --git a/drivers/nvmem/ast2600-otp.c b/drivers/nvmem/ast2600-otp.c
> > new file mode 100644
> > index 0000000..94b1225
> > --- /dev/null
> > +++ b/drivers/nvmem/ast2600-otp.c
> > @@ -0,0 +1,259 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) ASPEED Technology Inc.
> > + *
> > + * ASPEED AST2600 OTP Controller driver
> > + * Read sequencing adapted from ASPEED's downstream ast2600-otp driver=
.
>
> This comment feels unnecessary. It's already been said in the commit
> description.
>
> > + */
> > +
> > +#include <linux/align.h>
>
> align could be removed if you use round_down() or word & ~1 maybe?
>
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/of.h>
>
> You don't call any of_ functions. Replace with mod_devicetable.h.
>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
>
> unused. devm_kzalloc comes through platform_device.h.
>
> > +#include <linux/string.h>
> > +
> > +#define AST2600_OTP_PROTECT_KEY              0x00
> > +#define AST2600_OTP_CMD                      0x04
> > +#define AST2600_OTP_ADDR             0x10
> > +#define AST2600_OTP_STATUS           0x14
>
> The SB Controller driver checks for the OTP_PROTECTED bit. What happens
> if OTP protection is enabled?
>
> > +#define AST2600_OTP_COMPARE_1                0x20
> > +#define AST2600_OTP_COMPARE_2                0x24
> > +
> > +#define AST2600_OTP_CMD_READ         0x23b1e361
> > +#define AST2600_OTP_CMD_WRITE_MODE   0x23b1e362
> > +#define AST2600_OTP_UNLOCK_KEY               0x349fe38a
> > +#define AST2600_OTP_STATUS_DONE              0x6
>
> Describe the bits here. Either two BIT() or GENMASK(2, 1).
>
> > +#define AST2600_OTP_TIMEOUT_US               100000
>
> Where does this come from?
>
> > +
> > +#define AST2600_OTP_DATA_WORDS               0x800
> > +#define AST2600_OTP_SIZE                     (AST2600_OTP_DATA_WORDS *=
 sizeof(u32))
> > +#define AST2600_OTP_CONF0_ADDR               0x800
> > +#define AST2600_OTP_CONF0_SEC_SIZE           GENMASK(21, 16)
> > +#define AST2600_OTP_SEC_SIZE_UNIT            (32 * sizeof(u32))
> > +
> > +struct ast2600_otp {
> > +     void __iomem *base;
> > +     /* Serialize the complete unlock, read and relock sequence. */
> > +     struct mutex lock;
> > +     bool failed;
> > +};
> > +
> > +static int ast2600_otp_wait_complete(struct ast2600_otp *otp)
> > +{
> > +     u32 status;
> > +     int i, ret;
> > +
> > +     /* Allow the command to start before sampling the idle flags. */
> > +     udelay(1);
>
> You could use read_poll_timeout too?
>
> > +
> > +     /* Match the downstream sequence: observe both idle flags twice. =
*/
> > +     for (i =3D 0; i < 2; i++) {
>
> This is not a valid reason. Do you really have to poll twice? Is this an
> erratum? If so, please cite it.
>
> > +             ret =3D readl_poll_timeout(otp->base + AST2600_OTP_STATUS=
,
> > +                                      status,
> > +                                      (status & AST2600_OTP_STATUS_DON=
E) =3D=3D
> > +                                      AST2600_OTP_STATUS_DONE,
> > +                                      1, AST2600_OTP_TIMEOUT_US);
> > +             if (ret) {
> > +                     /* Do not reuse a controller with an outstanding =
command. */
> > +                     otp->failed =3D true;
>
> That'd disable the device on a single timeout. Do we really have to do
> this, or would it be enough to retry on the next access? If you want to
> keep it, then a dev_err() would be good instead of failing it silently.
>
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ast2600_otp_prepare_read(struct ast2600_otp *otp)
> > +{
> > +     static const u32 mode_addresses[] =3D { 0x3000, 0x5000, 0x1000 };
> > +     int i, ret;
> > +
> > +     ret =3D ast2600_otp_wait_complete(otp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * Restore the macro's default read mode, as in otp_soak(ctx, 0).
> > +      * These writes target volatile mode registers, not OTP fuse cell=
s.
> > +      * No fuse programming command or programming timing is used.
> > +      */
> > +     for (i =3D 0; i < ARRAY_SIZE(mode_addresses); i++) {
> > +             writel(mode_addresses[i], otp->base + AST2600_OTP_ADDR);
> > +             writel(0, otp->base + AST2600_OTP_COMPARE_1);
> > +             writel(AST2600_OTP_CMD_WRITE_MODE, otp->base + AST2600_OT=
P_CMD);
>
> Setting the OTP back to default doesn't need write mode if I understand
> the datasheet correctly.
>
> > +             ret =3D ast2600_otp_wait_complete(otp);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ast2600_otp_read_pair(struct ast2600_otp *otp,
> > +                              unsigned int aligned_word,
> > +                              u32 *word0, u32 *word1)
> > +{
> > +     int ret;
> > +
> > +     /* The hardware reads two words starting at an even word index. *=
/
> > +     if ((aligned_word & 1) || aligned_word >=3D AST2600_OTP_DATA_WORD=
S)
> > +             return -EINVAL;
>
> You're already passing an aligned index everywhere which makes this code
> redundant. It also blocks the read for CONF0, so please drop this check
> and use read_pair() for CONF0 too.
>
> > +
> > +     writel(aligned_word, otp->base + AST2600_OTP_ADDR);
> > +
> > +     writel(AST2600_OTP_CMD_READ,
> > +            otp->base + AST2600_OTP_CMD);
> > +
> > +     ret =3D ast2600_otp_wait_complete(otp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     *word0 =3D readl(otp->base + AST2600_OTP_COMPARE_1);
> > +     *word1 =3D readl(otp->base + AST2600_OTP_COMPARE_2);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ast2600_otp_read(void *context, unsigned int offset,
> > +                         void *val, size_t bytes)
> > +{
> > +     struct ast2600_otp *otp =3D context;
> > +     u8 *buf =3D val;
> > +     unsigned int word_index;
> > +     unsigned int aligned_word;
> > +     unsigned int secure_size;
> > +     __le32 pair[2];
> > +     u32 conf0;
> > +     u32 word0, word1;
> > +     size_t chunk, skip;
> > +     int ret;
> > +
> > +     if (!bytes)
> > +             return -EINVAL;
>
> OTP could be empty too?
>
> > +
> > +     if (offset % sizeof(u32) || bytes % sizeof(u32))
> > +             return -EINVAL;
> > +
> > +     if (offset >=3D AST2600_OTP_SIZE ||
> > +         bytes > AST2600_OTP_SIZE - offset)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&otp->lock);
>
> guard(mutex)(&priv->lock); ? Requires <linux/cleanup.h>.
>
> > +
> > +     if (otp->failed) {
> > +             ret =3D -EIO;
> > +             goto out_unlock;
> > +     }
> > +
> > +     writel(AST2600_OTP_UNLOCK_KEY, otp->base + AST2600_OTP_PROTECT_KE=
Y);
> > +
> > +     ret =3D ast2600_otp_prepare_read(otp);
> > +     if (ret)
> > +             goto out_lock;
>
> The secure region size is fixed once programmed. Maybe read it once in
> probe instead of on every access? With nvmem_keepout, this would clean
> up the read path a bit.
>
> > +
> > +     /* Configuration word 0 describes the unreadable secure data pref=
ix. */
> > +     writel(AST2600_OTP_CONF0_ADDR, otp->base + AST2600_OTP_ADDR);
> > +     writel(AST2600_OTP_CMD_READ, otp->base + AST2600_OTP_CMD);
> > +     ret =3D ast2600_otp_wait_complete(otp);
> > +     if (ret)
> > +             goto out_lock;
> > +
> > +     conf0 =3D readl(otp->base + AST2600_OTP_COMPARE_1);
> > +     secure_size =3D FIELD_GET(AST2600_OTP_CONF0_SEC_SIZE, conf0) *
> > +                   AST2600_OTP_SEC_SIZE_UNIT;
>
> You can also keep out the secure region by using nvmem_keepout.
>
> > +     /* Conservatively deny the entire secure prefix, including its he=
ader. */
> > +     if (offset < secure_size) {
> > +             ret =3D -EACCES;
> > +             goto out_lock;
> > +     }
> > +
> > +     while (bytes) {
> > +             word_index =3D offset / sizeof(u32);
> > +             aligned_word =3D ALIGN_DOWN(word_index, 2);
> > +
> > +             ret =3D ast2600_otp_read_pair(otp, aligned_word,
> > +                                         &word0, &word1);
> > +             if (ret)
> > +                     goto out_lock;
> > +
> > +             pair[0] =3D cpu_to_le32(word0);
> > +             pair[1] =3D cpu_to_le32(word1);
> > +             skip =3D (word_index - aligned_word) * sizeof(u32);
> > +             chunk =3D min(bytes, sizeof(pair) - skip);
> > +
> > +             memcpy(buf, (u8 *)pair + skip, chunk);
> > +             buf +=3D chunk;
> > +             offset +=3D chunk;
> > +             bytes -=3D chunk;
>
> NVMEM already returns the data in the correct order if I see this right.
> You can store the readl() results directly into a u32*buf var. That'd
> make the pair/skip/chunk code and endianness conversion unnecessary.
>
> > +     }
> > +
> > +     ret =3D 0;
> > +
> > +out_lock:
> > +     writel(0, otp->base + AST2600_OTP_PROTECT_KEY);
> > +     /* Flush the protection write before another reader takes the mut=
ex. */
> > +     readl(otp->base + AST2600_OTP_PROTECT_KEY);
>
> for what are you reading the otp key register here?
>
> > +out_unlock:
> > +     mutex_unlock(&otp->lock);
> > +     return ret;
> > +}
> > +
> > +static int ast2600_otp_probe(struct platform_device *pdev)
> > +{
> > +     struct nvmem_config config =3D {};
> > +     struct nvmem_device *nvmem;
> > +     struct ast2600_otp *otp;
>
> Can we name this priv maybe?
>
> > +
> > +     otp =3D devm_kzalloc(&pdev->dev, sizeof(*otp), GFP_KERNEL);
>
> Maybe assign &pdev->dev as struct device * variable and use that one
> instead?
>
> > +     if (!otp)
> > +             return -ENOMEM;
> > +
> > +     otp->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(otp->base))
> > +             return PTR_ERR(otp->base);
> > +
> > +     mutex_init(&otp->lock);
>
> devm_mutex_init?
>
> > +
> > +     config.dev =3D &pdev->dev;
>
> Same here with the var.
>
> > +     config.name =3D "ast2600-otp";
> > +     config.id =3D NVMEM_DEVID_AUTO;
> > +     config.owner =3D THIS_MODULE;
> > +     config.type =3D NVMEM_TYPE_OTP;
> > +     config.read_only =3D true;
> > +     config.root_only =3D true;
> > +     config.word_size =3D sizeof(u32);
> > +     config.stride =3D sizeof(u32);
> > +     config.size =3D AST2600_OTP_SIZE;
> > +     config.reg_read =3D ast2600_otp_read;
>
> These can already be set in the config struct before.
>
> > +     config.priv =3D otp;
> > +
> > +     nvmem =3D devm_nvmem_register(&pdev->dev, &config);
>
> And here.
>
> > +     return PTR_ERR_OR_ZERO(nvmem);
> > +}
> > +
> > +static const struct of_device_id ast2600_otp_of_match[] =3D {
> > +     { .compatible =3D "aspeed,ast2600-sbc" },
>
> The SB Controller driver has "additionalProperties: false" set and
> doesn't allow nvmem properties.
>
> Please add "$ref: /schemas/nvmem/nvmem.yaml#" and
> "unevaluatedProperties: false" as a separate patch.
>
> Tan
>
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ast2600_otp_of_match);
> > +
> > +static struct platform_driver ast2600_otp_driver =3D {
> > +     .probe =3D ast2600_otp_probe,
> > +     .driver =3D {
> > +             .name =3D "ast2600-otp",
> > +             .of_match_table =3D ast2600_otp_of_match,
> > +     },
> > +};
> > +module_platform_driver(ast2600_otp_driver);
> > +
> > +MODULE_AUTHOR("Neal Liu <neal_liu@aspeedtech.com>");
> > +MODULE_AUTHOR("Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>=
");
> > +MODULE_DESCRIPTION("ASPEED AST2600 read-only OTP NVMEM driver");
> > +MODULE_LICENSE("GPL");
> > base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>

