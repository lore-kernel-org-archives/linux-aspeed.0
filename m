Return-Path: <linux-aspeed+bounces-4266-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E20CD98EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Jun 2026 23:58:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gg3qP5kh5z3c4v;
	Wed, 17 Jun 2026 09:58:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781595065;
	cv=none; b=MLiIAD6wsVgyPeX1pr4sEROKaaSQl89f647GuceyhDlOscifmOj2L0e0JxIwQWqQd+zSd0UZn2pfSDvkf61P2TP0enZyDg3JYnL7BKca02mSdC3tjgaWI+eNYCue0G1d6Sjpj7y1xhHDDe6JY7Aoz7edqu8139dHPXMyGTe007M1UAv2JWuEBGdpcHLIm8CkKBacQYdMfr4Zij9f0Qi5SN+2jrLeKojMag7jJZABplA4ZsGOGP/5leieoOOuWNzTwuU/4r8CaQSXD/PLgRL2O7/Pbg6HoNL7XtbUXHX3drMLOpKkob+W/jvNW80Ni2jXVLBz5kSqRVEtv/RYLUd51A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781595065; c=relaxed/relaxed;
	bh=O+WDurAqpK+dkb0URg/+1yUjEvRH9T2h7sdxZWsTGMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAe+dHK68ZGrYBmmEZkPEk+AmC9UxcBfprl7derXsDB5mH1lxJPxSxyo9zRzA7Aen5QrS4m3ODlVp1kXabAf905vlOMfcvERVN++qJaqe3+e5zOL8vyNBtRbyGZbD0fFG9uDAPHhnL46F3lZbfpYmIPOYlXFGq6uctt/QXjO5u827IyExYmQXSib95Kdc4UxvRhPx3kz1F4mpXWxNzuCJUrCDLUn+PJyAyb0vxwuNUWG6e1jWBLbX3dlKhIRk70Bo+rLHS1Mc2cflGk+eb988vhpuJrU2GTizt9NSQ1dydl1nbmKFGZ8MpOGruAIbKSBHr3mZC9isI5MNTc0uoQbHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ffXOoQ0a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ffXOoQ0a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfdvW3Bfvz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Jun 2026 17:31:03 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2bf22d29dabso25938345ad.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Jun 2026 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781595061; x=1782199861; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+WDurAqpK+dkb0URg/+1yUjEvRH9T2h7sdxZWsTGMw=;
        b=ffXOoQ0apTxLZyXI2JqWWO6upOQ8+u3Ka4bonvUf8/SwPVt/fkr5DSuee3lc2j2lAi
         0GWVrQXyFwaUUFWCXa/NpDYjOKv8dueiue8T5+18Mt6bxQp4nLlDzI/iCVJAi48gg4BR
         WRnoI++rElJxhuKwfgFtdYcZi8dssfh6u3U8qclpd7HUCHuooZs/FLIHEVLbOlvFsXJF
         /FeFjsoEEv5zWAAXRbjilTf5Mx3ow8NIK1iKG+nGgUPSh9rGZKiFZ8VCz+ZH5EZSJt6i
         LaHHMRjfvG/XozA9N47kLYj1A95NlI8RMGWk6r2YO/m7hxC7A+jD4ibmE+uWYr+kw/cP
         sLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781595061; x=1782199861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+WDurAqpK+dkb0URg/+1yUjEvRH9T2h7sdxZWsTGMw=;
        b=HAEqcOhmfmdvlXG3pe8rDRRmnR7uthYohIh5HCdA7/IJDcYoQLRay+8tEzc9rkcX14
         AXdYsMCb36/8XjBFRZmHhQgWLGaFvO61qgxdipl5ZWRvlkQrAivcqbeUwU1MN/s7+aY5
         j4GlY0Hu6Pt5DXpe62SqY57ZzCL9iViZjWNRKZN+dsU5CG54Eg1sxZAZpphu/3B5RuGq
         f3kxPm5K77w21VDtMvz4OGzqY0oAcpvlh/jGY8zmSxon0M+sZrYttSv+6hTL9MyoTyV9
         96zpCvfAKbMkrZxDdVoKP1Ir+hr2csBU+N2G5Cm+NBc7ZOSyu5MzbxNNsxcu4k4+X+XW
         DSvA==
X-Forwarded-Encrypted: i=1; AFNElJ/IxL1hM8vVTH9dst/wjyXmr7hWIblZdEP/f0NehEq7462JSgk0JYA1hGMPxTEpRbJtahK7ov2/+6lxzM8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyCBuFXiX8HPkclWFfxvOcbTnf8X0O8QEnDQ/90dc8aUlL51Ygu
	/mgkXZtZRmJH+0pTC4bGgeOYLlwHXBwpy4cvYLq81Cmp++seCd6jZzxEeRk/EBOE
X-Gm-Gg: Acq92OGAtFl23zeeF7N3bLVliT52dwClSx3h8hc6akJFs0AnpNPMYGK+qK8d93aSyVu
	jfu8Ln/3/mMlf6KGa+TdnI9vYxClk5DqxDj0OsFOaugK1jtKc1sOPSlNd4eCInfYvfZGoFz15lk
	ILb+12Ow7TiP8rfYau8Ui1o6LNl3UpIWZ2fDTIBiY6mcCO8Kz9CGEX8bGYqwOgQ2hKIsK+p5W5U
	CMLuvpvjyN7UQ8BflXEoU9ADDJ/R/Fz0FV62bGh6iZfT+7rvdUrkAvaqc8gRH1NExxFPgoa5ioE
	0gFkhUMJ45dfR09Uqvg31D7ksyz7m+U5yaBrFvaHy8uV+06XX85t1dLs0XJwTYM6QkjPafVjCUA
	QjJwqlyUDaKWIQugf5WvAtUWF7AvaiCO1Hq9umDHn9Tdqd36sfFrIIYKzfKJ0NpqQTejls4+EUN
	uCfMPm2kFsKgJrXZdBEFjwoRM8zxNz83M5hGnBi15tjNUijbxZcOaWl34=
X-Received: by 2002:a17:903:11cd:b0:2c2:21e9:5a7d with SMTP id d9443c01a7336-2c69a21d05bmr26333555ad.34.1781595060778;
        Tue, 16 Jun 2026 00:31:00 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.200.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433460a60sm147542995ad.76.2026.06.16.00.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:31:00 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Tue, 16 Jun 2026 07:30:53 +0000
Message-ID: <20260616073053.1144730-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Happy to. Short version: ast2600-evb can't hit the SMP timing window,
so I reproduce each missing piece deliberately. The driver code under
test is unmodified -- only the stimulus and the post-race state are
injected. Stock qemu-system-arm (Debian 8.2.2), no QEMU changes.

Three obstacles, and what I did about each:

1. No BIOS to emit POST codes -- an injection module stages bytes into
   the snoop registers via the LPC syscon regmap (SNPWDR + the HICR6
   data-ready bit).

2. QEMU doesn't raise the snoop IRQ for those writes -- after staging,
   the module dispatches it in software with
   generic_handle_irq_safe(sdev->irq), which runs the driver's real
   aspeed_lpc_snoop_irq() -> put_fifo_with_discard() path.

3. The SMP race won't trigger under TCG -- so I reconstruct its outcome
   instead: force the channel-0 kfifo to in=4097, out=1, i.e.
   (in - out) = 4096 > the 2048-byte ring, the exact state a reader
   observes inside the window.

One caveat so it isn't misread: step 3 writes in/out directly, so it
bypasses the new lock. The patched run therefore shows the read path no
longer turns a corrupt (in - out) into a usercopy overflow; the lock's
job of preventing that state is the SPSC argument from the commit, which
TCG can't exercise.

== Tree / config ==

  base:  v7.1-rc7
  clang: 22.1.7 (LLVM=-22; needed for the context-analysis check)
  ARM multi_v7_defconfig + CONFIG_CC_IS_CLANG, WARN_CONTEXT_ANALYSIS,
  SMP, ASPEED_LPC_SNOOP, HARDENED_USERCOPY, PROVE_LOCKING,
  DEBUG_ATOMIC_SLEEP.

  make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=-22 O=build \
       -j$(nproc) zImage

== Run ==

The injection module (full source below the sign-off) creates two
write-only sysfs knobs under /sys/kernel/snoop_test/. The init loads it,
then:

  echo 4096 > /sys/kernel/snoop_test/generate    # fill via the real
                                                  # IRQ path 
  echo 1    > /sys/kernel/snoop_test/adjust_ptrs  # force in=4097/out=1
                                                  
  read(fd, buf, 4096) from /dev/aspeed-lpc-snoop0 # the overflowing read

Build it against the same tree (-DSNOOP_PATCHED for v6, which mirrors the
spinlock the fix adds ahead of @fifo; omit it for the unpatched build).

  qemu-system-arm -M ast2600-evb -smp 2 \
    -kernel build/arch/arm/boot/zImage \
    -dtb build/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb \
    -initrd repro.cpio.gz \
    -append "console=ttyS4,115200 panic=-1" -nographic -no-reboot

== Result ==

Unpatched, read(4096) with in=4097/out=1:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'kmalloc-2k' (offset 0, size 2049)!
   kfifo_copy_to_user / __kfifo_to_user / snoop_file_read / vfs_read
  Kernel panic - not syncing: Fatal exception

Patched: read() returns 2048, no panic; no lockdep or atomic-sleep
splats.

The init is just: mount proc/sysfs/devtmpfs, finit_module() the .ko,
write the two knobs above, then read(4096) from the char device. Full
injection module follows.

Thanks,
Karthikeyan

------ snoop_test_inject.c (build as an out-of-tree module) ------

// SPDX-License-Identifier: GPL-2.0
/*
 * Reproduce the aspeed-lpc-snoop kfifo SPSC-violation post-race state
 * deterministically under QEMU. Two write-only sysfs knobs under
 * /sys/kernel/snoop_test/:
 *
 *   generate <count>  Push <count> POST-code bytes through the *real*
 *                     driver IRQ path: write SNPWDR + HICR6 via the LPC
 *                     syscon regmap, then dispatch the snoop IRQ so
 *                     aspeed_lpc_snoop_irq() -> put_fifo_with_discard()
 *                     runs.
 *
 *   adjust_ptrs <1>   Force the channel-0 kfifo into the state a reader
 *                     observes inside the race window: in = 4097,
 *                     out = 1, so (in - out) = 4096 > the 2048-byte ring.
 *
 * The driver's private channel is reached through a mirror struct whose
 * layout must match drivers/soc/aspeed/aspeed-lpc-snoop.c. The v6 fix
 * inserts a spinlock_t ahead of @fifo -- build with -DSNOOP_PATCHED to
 * mirror that, otherwise the &fifo offset is wrong.
 */
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/version.h>
#include <linux/fs.h>
#include <linux/file.h>
#include <linux/kfifo.h>
#include <linux/miscdevice.h>
#include <linux/regmap.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/irqdesc.h>
#include <linux/device.h>
#include <linux/kobject.h>
#include <linux/sysfs.h>
#include <linux/wait.h>
#include <linux/spinlock.h>
#include <linux/bitops.h>

#define HICR6			0x84
#define HICR6_STR_SNP0W		BIT(0)
#define SNPWDR			0x94
#define SNOOP_DEV		"/dev/aspeed-lpc-snoop0"
#define RACE_OUT		1u
#define RACE_IN			4097u

struct snoop_chan_mirror {
	const void		*cfg;
	bool			enabled;
#ifdef SNOOP_PATCHED
	spinlock_t		lock;		/* added by the fix */
#endif
	struct kfifo		fifo;
	wait_queue_head_t	wq;
	struct miscdevice	miscdev;
};

struct snoop_dev_mirror {
	struct regmap		*regmap;
	int			irq;
	/* struct clk *clk; struct aspeed_lpc_snoop_channel chan[2]; follow */
};

static struct file *snoop_open(struct snoop_chan_mirror **chan_out)
{
	struct file *filp;
	struct miscdevice *md;

	filp = filp_open(SNOOP_DEV, O_RDONLY | O_NONBLOCK, 0);
	if (IS_ERR(filp))
		return filp;

	md = filp->private_data;
	if (!md) {
		filp_close(filp, NULL);
		return ERR_PTR(-ENODEV);
	}

	*chan_out = container_of(md, struct snoop_chan_mirror, miscdev);
	return filp;
}

static ssize_t generate_store(struct kobject *kobj, struct kobj_attribute *attr,
			      const char *buf, size_t len)
{
	struct snoop_chan_mirror *chan;
	struct snoop_dev_mirror *sdev;
	struct file *filp;
	unsigned int count, i;
	int rc;

	rc = kstrtouint(buf, 0, &count);
	if (rc)
		return rc;

	filp = snoop_open(&chan);
	if (IS_ERR(filp))
		return PTR_ERR(filp);

	sdev = dev_get_drvdata(chan->miscdev.parent);
	if (!sdev || !sdev->regmap || sdev->irq <= 0) {
		filp_close(filp, NULL);
		return -ENODEV;
	}

	for (i = 0; i < count; i++) {
		/* Stage the snoop'ed byte and the data-ready status bit. */
		regmap_write(sdev->regmap, SNPWDR, (u32)(i & 0xff));
		regmap_write(sdev->regmap, HICR6, HICR6_STR_SNP0W);

		/*
		 * Dispatch IRQ -> aspeed_lpc_snoop_irq() ->
		 * put_fifo_with_discard(). generic_handle_irq_safe() copes
		 * with the GIC requiring the handler to run with IRQs off.
		 */
		generic_handle_irq_safe(sdev->irq);
	}

	filp_close(filp, NULL);
	return len;
}

static ssize_t adjust_ptrs_store(struct kobject *kobj, struct kobj_attribute *attr,
				 const char *buf, size_t len)
{
	struct snoop_chan_mirror *chan;
	struct file *filp;
	struct __kfifo *kf;
	unsigned int val;
	int rc;

	rc = kstrtouint(buf, 0, &val);
	if (rc)
		return rc;
	if (val != 1)
		return -EINVAL;

	filp = snoop_open(&chan);
	if (IS_ERR(filp))
		return PTR_ERR(filp);

	kf = &chan->fifo.kfifo;
	/* Reproduce the race outcome: fresh 'in', stale 'out'. */
	WRITE_ONCE(kf->out, RACE_OUT);
	WRITE_ONCE(kf->in, RACE_IN);
	pr_info("snoop_test: in=%u out=%u (in-out=%u, size=%u)\n",
		kf->in, kf->out, kf->in - kf->out, kf->mask + 1);

	filp_close(filp, NULL);
	return len;
}

static struct kobj_attribute generate_attr =
	__ATTR(generate, 0220, NULL, generate_store);
static struct kobj_attribute adjust_ptrs_attr =
	__ATTR(adjust_ptrs, 0220, NULL, adjust_ptrs_store);

static struct attribute *snoop_attrs[] = {
	&generate_attr.attr,
	&adjust_ptrs_attr.attr,
	NULL,
};
static const struct attribute_group snoop_group = { .attrs = snoop_attrs };
static struct kobject *snoop_kobj;

static int __init snoop_test_init(void)
{
	int rc;

	snoop_kobj = kobject_create_and_add("snoop_test", kernel_kobj);
	if (!snoop_kobj)
		return -ENOMEM;

	rc = sysfs_create_group(snoop_kobj, &snoop_group);
	if (rc) {
		kobject_put(snoop_kobj);
		return rc;
	}
	return 0;
}

static void __exit snoop_test_exit(void)
{
	sysfs_remove_group(snoop_kobj, &snoop_group);
	kobject_put(snoop_kobj);
}

module_init(snoop_test_init);
module_exit(snoop_test_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("aspeed-lpc-snoop kfifo race post-state reproducer");

