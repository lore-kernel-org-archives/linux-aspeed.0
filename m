Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98835606A31C
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Nov 2026 05:16:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSbg50Btbz2xnn;
	Mon, 16 Nov 2026 16:16:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794806160;
	cv=none; b=hFrcIfqyVlx+i2ZuPjwYlMmAGOfuIgcg+VF85+0cS9IZ70STAT25ona6NXilJhN2/2lq/fm3j//JslZqbKMFlzrs1ojYtBaaOIvu+uBT6IiGPZAs0wev4JB8TvVfutDap2iOv4g519AxcR9oZT28bJcMXJvUkGbW4CAxgIPTTc8kCdPW3PbuXJf/b+pJLo6Jay/QWMR6TCbrD8zNG9XJ/GzWrC5WLjvF9/RQZpqGNr9Dpo+PZ7CRgr4Q9YPGMS/TUs8x2t0vheSEcI+LPqfZhVhdbtBrAIlcsgopz/zHBrlAlL3cr88JWvU6hqYCGph8fIiYj9EDGviPaR3DlLpAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794806160; c=relaxed/relaxed;
	bh=zIG1Zp6FGJRrEDh0pN+mqn8C1jWGbL1fAfu3HFYFjzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BatLN7RBXasIF1KtCYmkdNHCtP6XdLFjW1tcdoKZ/3AbA9Jfg8psnKQjDi1zabc0BemYZLR8l5bdSXP6gXWKoBW9duAxOh+UvUBf8moXnweYoQMiTyqQh+LxUgKVs5fCcqMpmx7JZoLmoiAgYQqbHlU17hTeF7KwQIgz9Xb8J+Wr3YGdS9UXatrITdhoR6bQNIuGs4CbeqkR+Zb35+wNGzy2Bd5f2fIBtVUB2cLTxsUuU8Wy4THN3eJa1f6BrXB4HepjtRBUUOn6XzTRjr/K+FbwRkqDOfcjSpKdRfdYeefK+2uvXl7B/fKXll62KV2KVnpv2GAfAusZfome+CjKag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=cooper_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=cooper_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSbg34HLjz2xjv
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Nov 2026 16:15:58 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 16 Nov
 2026 13:15:41 +0800
Received: from aspeed-fw03.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 16 Nov 2026 13:15:41 +0800
From: Cooper Huang <cooper_huang@aspeedtech.com>
To: <andrew@codeconstruct.com.au>
CC: <billy_tsai@aspeedtech.com>, <chin-ting_kuo@aspeedtech.com>,
	<conor+dt@kernel.org>, <cooper_huang@aspeedtech.com>,
	<devicetree@vger.kernel.org>, <joel@jms.id.au>, <krzk+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>,
	<ryan_chen@aspeedtech.com>, <vince_chang@aspeedtech.com>
Subject: Re: [PATCH] arm64: dts: aspeed: Enlarge AST2700 EVB kernel partition to 12 MiB
Date: Mon, 16 Nov 2026 13:15:41 +0800
Message-ID: <20261116051541.3503805-1-cooper_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bc6e605a8c5bee59ad9bcbce5f4fe775c9c3324e.camel@codeconstruct.com.au>
References: <bc6e605a8c5bee59ad9bcbce5f4fe775c9c3324e.camel@codeconstruct.com.au>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

Thanks for the review. I've gone back and measured things more
carefully; details inline.

On Tue, 2026-11-03 at 14:48 +1030, Andrew Jeffery wrote:
> On Thu, 2026-10-29 at 15:25 +0800, Cooper Huang wrote:
> > The 128 MiB flash layout of the AST2700 EVB reserves 9 MiB for the
> > kernel FIT image. A FIT image containing an LZMA-compressed kernel,
> > the DTB and an initramfs is already close to that size, leaving little
> > room for the kernel to grow.
> >
> > Grow the kernel partition to 12 MiB and take the 3 MiB from rofs,
>
> Why 12MiB? Why only take 3MiB?

We chose 12MiB to give roughly 3MiB of headroom over the current FIT
while keeping u-boot, u-boot-env and rwfs (and so the persistent data
in rwfs) where they are. It's an engineering margin rather than a
derived figure, and there's no single correct size here, but the
measurements below suggest it's a reasonable choice.

The space comes from rofs because that's where the slack is: the EVB
rofs image is about 38.4MiB, well within the 79.875MiB that remains.

The LZMA-compressed kernel built with aspeed_g7_defconfig grew by
65-72KiB from v7.2 to v7.3, and by 78-89KiB from v7.3 to c339f4010dea,
depending on the compiler. With a 12MiB partition the FIT still has
2.93MiB free in the worst case measured (05441d697f7f with GCC 14.2),
providing headroom for future kernel growth and additional AST2700
drivers.

We're open to a different size if you'd prefer one.

> > which now starts at 0x1020000 and shrinks from 82.875 MiB to
> > 79.875 MiB. rofs still ends at 0x6000000, so the u-boot, u-boot-env
> > and rwfs partitions are unchanged.
> >
> > This is the same layout used by the OpenBMC images ASPEED provides
> > for the EVB [1],
> >
>
> Why was what was sent upstream different to what you were doing
> elsewhere in the software stack? It seems oddly incoherent.

It wasn't different at the time. The 9MiB layout from commit
e77bb5dc5759 ("arm64: dts: aspeed: Add initial AST27xx SoC device
tree"), which was posted and applied on 2026-06-09 for v7.2, matched
what the SDK was using then. The SDK only moved to 12MiB later, on
2026-08-24 [3], and this patch is meant to bring upstream back in line
with it. I should have explained that in the commit message rather
than making it look as though upstream had diverged.

> > Notes:
> > - "Already close to that size": with mainline at c339f4010dea
> >   (v7.3-17997), ASPEED's aspeed_g7_defconfig [2] and GCC 13.2, a FIT
>
> A bit of a tangent, but GCC 13.2 is over 3 years old at this point.
> Debian stable ships 14.2. Why such an old compiler?

No particular reason; it's just the cross toolchain in my local build
environment. I've now also measured with the kernel.org crosstool
builds of GCC 14.2, 15.3 and 16.2. The older compiler doesn't change
the conclusion. If anything GCC 14.2 makes it worse: its compressed
kernel is about 1% larger than GCC 13.2's, and with it the FIT no
longer fits in 9MiB at c339f4010dea.

  Free space left in a 9MiB partition, in KiB (negative: doesn't fit)

                  GCC 13.2  GCC 14.2  GCC 15.3  GCC 16.2
  v7.2               165.4      98.0     167.1     153.9
  v7.3               100.7      29.2      96.1      81.9
  c339f4010dea        16.8     -59.8      16.5       4.1
  05441d697f7f         8.5     -69.1      10.8      -3.0

05441d697f7f is mainline master as of 2026-11-03.

> >   image with the LZMA-compressed kernel, ast2700-evb.dtb and the
> >   OpenBMC phosphor initramfs is about 8.99 MiB, less than 20 KiB
>
> What are your measured sizes for the kernel vs the initramfs?

At c339f4010dea, in bytes:

  GCC    Image.lzma     DTB  initramfs        FIT
  13.2    7,930,161  36,758  1,451,420  9,420,020
  14.2    8,008,518  36,758  1,451,420  9,498,376
  15.3    7,930,429  36,758  1,451,420  9,420,288
  16.2    7,943,155  36,758  1,451,420  9,433,012

The kernel is about 84% of the FIT, the initramfs about 15% and the
DTB 0.4%. Every commit/compiler combination in the table above has
the same split (83.9-84.3% kernel).

All builds used aspeed_g7_defconfig from [2] plus olddefconfig, then
"make Image.lzma aspeed/ast2700-evb.dtb". Each FIT was packed with
mkimage using the same initramfs from our OpenBMC SDK build. With
KBUILD_BUILD_TIMESTAMP/USER/HOST fixed, two builds of the same commit
in different directories differ by only ~400 bytes compressed (the
only differences are the kernel and vDSO build IDs, which change with
the build directory), so the "few KiB between builds" in my notes was
overstated.

A caveat on the config: aspeed_g7_defconfig targets our SDK kernel.
On these mainline commits 344 of its 394 config entries apply. The
rest are mostly drivers that aren't upstream yet (eSPI, MCTP, LTPI,
JTAG and so on), plus FTGMAC100, which doesn't support arm64 upstream
yet. With the same config and compiler, the compressed kernel built
from our SDK tree (based on v6.18) is 357KiB larger than mainline
v6.18, and that gap includes the SDK's other changes as well as those
drivers. The mainline measurements therefore do not yet include all
the functionality enabled in our SDK, and additional upstream driver
support may increase the image size.

> Is the initramfs content reasonable?

Mostly, though there is some room to trim. It's the
obmc-phosphor-initramfs from our OpenBMC SDK build: 254 entries,
4.4MiB uncompressed and 1.38MiB xz-compressed. It contains busybox,
util-linux flock, the init/update/shutdown scripts and glibc 2.43,
which is the bulk of it at about 3.5MiB uncompressed.

busybox and flock only link directly against libc, libm and ld-linux,
but the whole glibc package is installed, including libmvec, libnsl,
libnss_compat, libresolv, libBrokenLocale and the compatibility stubs
(libdl, libpthread, librt, libutil, libanl, libnss_files, libnss_dns).
Based on that dependency check alone, dropping them would save about
160KiB compressed. I haven't yet verified that the boot and update
paths still work without them.

Even if all of it can go, that's a one-off saving of about 160KiB. In
the worst case above (05441d697f7f with GCC 14.2), the FIT would then
have only about 90KiB left in 9MiB. The FIT is dominated by the
kernel, whose compressed size grew by 65-72KiB from v7.2 to v7.3 and
by 78-89KiB from v7.3 to c339f4010dea.

If this sounds reasonable, I'll send a v2 with the rationale and
representative numbers in the commit message, and with the SDK
history described correctly.

[1] https://github.com/AspeedTech-BMC/openbmc/blob/438e761ed38644b77ba704c984cb607649bf2724/meta-aspeed-sdk/meta-ast2700-sdk/conf/machine/ast2700-default.conf
[2] https://github.com/AspeedTech-BMC/linux/blob/76457d3afe2bd4022ca82dd9eb8fc48b84f0e9ab/arch/arm64/configs/aspeed_g7_defconfig
[3] https://github.com/AspeedTech-BMC/openbmc/commit/f6671e0eb6a2c542bf3162df7c69906df7b301b7

Thanks,
Cooper

