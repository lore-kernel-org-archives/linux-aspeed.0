Return-Path: <linux-aspeed+bounces-3832-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CADCC6B3E
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Apr 2026 00:51:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn0Xn0Yf8z2yVv;
	Fri, 03 Apr 2026 11:51:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775177497;
	cv=none; b=luraSPwbXEDc4XCSltd7bk+vzvy6N/vnFYkszbHc/U7vVxIpoqVWDwJUrAR97nJYmi4cRuwVBA1UiBwsBvqjKjw1AHr4xPTIBqWWNI51BRQ12GR0iC8TeH0DJpZCiZDIyXHpYSHjpamjBUAdFmpXIYDGpfU1cY5LEFcAMu6QuyuIRf1ez6CtDzS9IoTH1WsmvL5YmR2aGV190KUhNbV+74dwCpeS76NOXIC2LHuQBeEHCNd6s6GqnZZuOwuC8eoQJTHkdvpii+iaC+GZQbzYU2l+JD4vbQFMHfBd3sEzXQEYahHtMNdgZqBSjASsy8F5E+3zOnmdgEnxjW5HiVWEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775177497; c=relaxed/relaxed;
	bh=Lb2HYWEQxB/om4yhyjxjNip9666HK8Fi8TGkiu9j7VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTLIi09iN3+NyGhMOIg152qTxn852qMoM+8hEpNRGpm+2HS7Mp8c95mD0cDS4dfZvk2fGFsU1Zkf+FmtjZ92IjMeQdNhX7mWvUsYBGKwEKAMfYlWqv2L4Mynlqv7YO8Gll1FfhnRxma/zRIitusHJgGy8MXelfsG5Ec243mzI55OfnrfdjeCmsV1uM7ukD/Soehb7DG9YIJMW98Y+E+NJV6FSZsCuDYELHYvlLvyjWOoz3uUc3YNHaTaE1y4hpzwvcLqrcrVipA8Drc9tocETfgoHab/62MB1jhtix1ylxph+GWOUGiVTyxq14g+qhcHBzo20kiqnSBKKuYvd5bgOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mJZrq6gJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mJZrq6gJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn0Xl6dkbz2xQD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Apr 2026 11:51:34 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-2cc1534e026so206282eec.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 02 Apr 2026 17:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177493; x=1775782293; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb2HYWEQxB/om4yhyjxjNip9666HK8Fi8TGkiu9j7VQ=;
        b=mJZrq6gJ0dZbXN6zpfOZGOnbmleJvjaIenImbgPyz5zlaOm3PyR2LRvkIrjYFf1TLg
         MA3S+IguAh6LVApq95/9CAdfPuYyI8mep5VjOnTGVgXA8m6Ic1xxya2HngaopTVRH5nK
         qY4yBM2oPlN4HMMi98/Grmbe1ybdbl62t1vXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177493; x=1775782293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb2HYWEQxB/om4yhyjxjNip9666HK8Fi8TGkiu9j7VQ=;
        b=PTZhi57N3BVu4y+ZygIPn99QEjGEE+Tgmr+HzYyHCrRF1t8YQD9KT3Jvy4C0I2ltyu
         5l1aPPgfQP8fkYiHA8VZpM6MMzZyNKNTmjboMEhN0NzpFlr3TrFVOOSP6jBraFvAZRfd
         tYsIr9y6tGKuiXMDm+C5MNQoXkwpo1WIZzsqNOlt8BY0KxJMFGHo0ReMlYLYTv38TXIz
         J6RqkYYiEMMwoG9n10DS/ZFBknhBwwI7hRMGgcsb+eA2Mt99aJL4l0SOdwoKthD4gh6b
         Zy/LMGyHhsjK5moh9U/mJfRokp+akFp7FwMZxm34GUnIgNZ5SFKZ4GVEx7NipGeXLdeB
         6AwA==
X-Forwarded-Encrypted: i=1; AJvYcCW0PYqdcQgH66lB16FuciuRrJk8B5HK1zf8g0kS39g9gIdU/OFAfkLxIFCdOGz7KPSn4OLvem1ts4Zfops=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZPhOwaUtRV24Hi/AlhbEQAXHz/wZjhm54pm8zqDlYoOq1HVjY
	xAjuR9gJfQrGUDyWv88tQzhPELn4WSXPRwUSkXa6kgIxPiGOQgwQqoLvIsf1lDl4Sg==
X-Gm-Gg: AeBDievbIWok7dZY5z8VKV7Aq60C6EpksqCYPx67GPWsH+42UomSu4kZL0TUWZTfEPu
	6/OFGDyq+1IN1klUpGSJqV+nDJdadlOHHomFLXGH1N9iiEhfuNz1j2xT/VHgeYatO3w58UKfLTU
	00HXuJNTKzILcnZi6lNaKvF8ReQllwBS9wpk5x42lEebXDY1USgWMIA4aAKhgNsj5VOfrjVn2A6
	XH0AZIkc34AyTLz3t/5CEcPdJF7Cz5wnmtCb4kio3FEjrlXGpLvvaROutSXLmiRnslXI6OoeUYM
	+yEG6q0gi6U7UmqxqkyT03+/zTRCpKPEekkCW2xsSnRL3VdYq5ia2Il5dDAFfJ5BnrrbccbJqXf
	yUrowqxQoQ9+fA5kyH2R/qx5a7ncWw2lezOxSlOaD5w+tgyecJ+gEXmPrcAECkladUjivDFAgie
	JsY8zq41KjY3PBFG/JhVWdx2e3ebwO19rI8oYP96KVJl+cTRZnV+oar4FsLUR60U9EDv9zXqTwq
	Di09FirjI5eOi+P65af8A==
X-Received: by 2002:a05:693c:3009:b0:2c1:558c:16f7 with SMTP id 5a478bee46e88-2cbf950392cmr655589eec.6.1775177492780;
        Thu, 02 Apr 2026 17:51:32 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:31 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frank.Li@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	alex@ghiti.fr,
	alexander.stein@ew.tq-group.com,
	andre.przywara@arm.com,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	astewart@tektelic.com,
	bhelgaas@google.com,
	brgl@kernel.org,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	chleroy@kernel.org,
	davem@davemloft.net,
	david@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	driver-core@lists.linux.dev,
	gbatra@linux.ibm.com,
	gregory.clement@bootlin.com,
	hkallweit1@gmail.com,
	iommu@lists.linux.dev,
	jirislaby@kernel.org,
	joel@jms.id.au,
	joro@8bytes.org,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	kuba@kernel.org,
	lenb@kernel.org,
	lgirdwood@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mani@kernel.org,
	maz@kernel.org,
	miko.lenczewski@arm.com,
	mpe@ellerman.id.au,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	oupton@kernel.org,
	pabeni@redhat.com,
	palmer@dabbelt.com,
	peter.ujfalusi@gmail.com,
	peterz@infradead.org,
	pjw@kernel.org,
	robh@kernel.org,
	sebastian.hesselbarth@gmail.com,
	tglx@kernel.org,
	tsbogend@alpha.franken.de,
	vgupta@kernel.org,
	vkoul@kernel.org,
	will@kernel.org,
	willy@infradead.org,
	yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: [PATCH v3 0/9] driver core: Fix some race conditions
Date: Thu,  2 Apr 2026 17:49:46 -0700
Message-ID: <20260403005005.30424-1-dianders@chromium.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
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

The main goal of this series is to fix the observed bug talked about
in the first patch ("driver core: Don't let a device probe until it's
ready"). That patch fixes a problem that has been observed in the real
world and could land even if the rest of the patches are found
unacceptable or need to be spun.

That said, during patch review Danilo correctly pointed out that many
of the bitfield accesses in "struct device" are unsafe. I added a
bunch of patches in the series to address each one.

Danilo said he's most worried about "can_match", so I put that one
first. After that, I tried to transition bitfields to flags in reverse
order to when the bitfield was added.

Even if transitioning from bitfields to flags isn't truly needed for
correctness, it seems silly (and wasteful of space in struct device)
to have some in bitfields and some as flags. Thus I didn't spend time
for each bitfield showing that it's truly needed for correctness.

Transition was done semi manually. Presumably someone skilled at
coccinelle could do a better job, but I just used sed in a heavy-
handed manner and then reviewed/fixed the results, undoing anything my
script got wrong. My terrible/ugly script was:

var=can_match
caps="${var^^}"
for f in $(git grep -l "[>\.]${var}[^1-9_a-zA-Z\[]"); do
  echo $f
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = true/set_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = true/set_bit(DEV_FLAG_${caps}, \&\\1.flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = false/clear_bit(DEV_FLAG_${caps}, \&\\1->flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = false/clear_bit(DEV_FLAG_${caps}, \&\\1.flags)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var} = \([^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1->flags, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var} = \([^;]*\)/assign_bit(DEV_FLAG_${caps}, \&\\1.flags, \\2)/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)->${var}\([^1-9_a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1->flags)\\2/" "$f"
  sed -i~ -e "s/\([a-zA-Z_0-9\.>()-][a-zA-Z_0-9\.>()-]*\)\.${var}\([^1-9_a-zA-Z\[]\)/test_bit(DEV_FLAG_${caps}, \&\\1.flags)\\2/" "$f"
done

NOTE: one potentially "controversial" choice I made in some patches
was to always reserve a flag ID even if a flag is only used under
certain CONFIG_ settings. This is a change from how things were
before. Keeping the numbering consistent and allowing easy
compile-testing of both CONFIG settings seemed worth it, especially
since it won't take up any extra space until we've added a lot more
flags.

I only marked the first patch as a "Fix" since it is the only one
fixing observed problems. Other patches could be considered fixes too
if folks want.

I tested the first patch in the series backported to kernel 6.6 on the
Pixel phone that was experiencing the race. I added extra printouts to
make sure that the problem was hitting / addressed. The rest of the
patches are tested with allmodconfig with arm32, arm64, ppc, and
x86. I boot tested on an arm64 Chromebook running mainline.

Changes in v3:
- Use a new "flags" bitfield
- Add missing \n in probe error message

Changes in v2:
- Instead of adjusting the ordering, use "ready_to_probe" flag

Douglas Anderson (9):
  driver core: Don't let a device probe until it's ready
  driver core: Replace dev->can_match with DEV_FLAG_CAN_MATCH
  driver core: Replace dev->dma_iommu with DEV_FLAG_DMA_IOMMU
  driver core: Replace dev->dma_skip_sync with DEV_FLAG_DMA_SKIP_SYNC
  driver core: Replace dev->dma_ops_bypass with DEV_FLAG_DMA_OPS_BYPASS
  driver core: Replace dev->state_synced with DEV_FLAG_STATE_SYNCED
  driver core: Replace dev->dma_coherent with DEV_FLAG_DMA_COHERENT
  driver core: Replace dev->of_node_reused with DEV_FLAG_OF_NODE_REUSED
  driver core: Replace dev->offline + ->offline_disabled with DEV_FLAGs

 arch/arc/mm/dma.c                             |  4 +-
 arch/arm/mach-highbank/highbank.c             |  2 +-
 arch/arm/mach-mvebu/coherency.c               |  2 +-
 arch/arm/mm/dma-mapping-nommu.c               |  4 +-
 arch/arm/mm/dma-mapping.c                     | 30 +++----
 arch/arm64/kernel/cpufeature.c                |  2 +-
 arch/arm64/mm/dma-mapping.c                   |  2 +-
 arch/mips/mm/dma-noncoherent.c                |  2 +-
 arch/powerpc/kernel/dma-iommu.c               |  8 +-
 .../platforms/pseries/hotplug-memory.c        |  4 +-
 arch/riscv/mm/dma-noncoherent.c               |  2 +-
 drivers/acpi/scan.c                           |  3 +-
 drivers/base/core.c                           | 55 +++++++-----
 drivers/base/cpu.c                            |  4 +-
 drivers/base/dd.c                             | 28 +++++--
 drivers/base/memory.c                         |  2 +-
 drivers/base/pinctrl.c                        |  2 +-
 drivers/base/platform.c                       |  2 +-
 drivers/dma/ti/k3-udma-glue.c                 |  6 +-
 drivers/dma/ti/k3-udma.c                      |  6 +-
 drivers/iommu/dma-iommu.c                     |  9 +-
 drivers/iommu/iommu.c                         |  5 +-
 drivers/net/pcs/pcs-xpcs-plat.c               |  2 +-
 drivers/of/device.c                           |  6 +-
 drivers/pci/of.c                              |  2 +-
 drivers/pci/pwrctrl/core.c                    |  2 +-
 drivers/regulator/bq257xx-regulator.c         |  2 +-
 drivers/regulator/rk808-regulator.c           |  2 +-
 drivers/tty/serial/serial_base_bus.c          |  2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c      |  2 +-
 include/linux/device.h                        | 83 ++++++++++---------
 include/linux/dma-map-ops.h                   |  6 +-
 include/linux/dma-mapping.h                   |  2 +-
 include/linux/iommu-dma.h                     |  4 +-
 kernel/cpu.c                                  |  4 +-
 kernel/dma/mapping.c                          | 16 ++--
 mm/hmm.c                                      |  2 +-
 37 files changed, 178 insertions(+), 143 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


