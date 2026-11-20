Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25660A3813
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Nov 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gKJlvuSG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWPt66G1Rz2xqJ;
	Sat, 21 Nov 2026 06:05:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795201518;
	cv=none; b=GE1KLIdQOvV0FrLuVxSITqucIO81YVWzc8wRJh2sRqWMyLMl/6XaYxwN7BLcvMWcWE8QWnoh27q75S1XkBS4WUwShcarJq9+/4+yIA2/VwnG4E7M7E58brVo1V7eoa7am5d0iRx21qv81QJEQjXSXvkCiGHZicLqyxNaE1KioC4WTzA5+SYUpPyRR+8wxhKtBb0CiiWldXGwnVFVFfvaoQkEGf17yWwWfZ8UeBiisBi4xTlCnfMbYlfURbBAbctLgnLVEIJWeo5ta52NWHPKYSfoE/YQd2VNSy2Oycev0tD0JTwQg60iSs6lwfm1Vnni0qhRmtpQIqb4EAAqLoYbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795201518; c=relaxed/relaxed;
	bh=oooEWJs9gjOAVhgIXEsvVmU0j/MFcc+cEdr5Tko/RTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qrg9t9dRa85dY45SsTJpoj2MHs/25cHUAx0mOAKwCXCb8tWyWq5uE1eHcKSEie5oz31a8bLdNFvi18Qseg3qiPGXuyZW+5ZPxSL5vCUtcA8McnzSPo9Kw73GvKv5o5Ydd5+wmdoTKtpwWiJrjdY5O82ng0w/FQoQTb+3Quug8yImB2hSAWUYoZxbRCsz3c6PtjzWLZdRTNcuxeagezaWtZh4RQSQOVwMxnjNqAWbXXyEdkzxrfl8X978lDf/2+hj2V+yD52iaqbHOWBCh3wcwvPPi3Cf8t3ofcVjKVecaa2uRhuyRwMWF9flVomjQti13HTF+lWVZCnH4ztPK7MSiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gKJlvuSG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gKJlvuSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWPt534jzz2xly
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Nov 2026 06:05:16 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so9205735e9.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1795201513; x=1795806313; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oooEWJs9gjOAVhgIXEsvVmU0j/MFcc+cEdr5Tko/RTA=;
        b=gKJlvuSGROTXxLIH01kU1gHyPS5eaPlZGAgR+W9pEFrKfDsMJqYbh66GHKSmBLs/vB
         PbGXDp5jFr2uAR2KC2SDPYdbP2bPKCfdwViUYKo1TmCENIi+gbct5osMGjjbdzsiVA98
         JA0Q+EQ9Id4bsRub1VZ8COOkxKLlf9uUnKPlJqb+/Ubrf6tNESzdGjHCMk0ef524N9Kw
         SkcBo9Ert5pQmc2jWBcUYNdJKKPs1ZY2hjPuM51bRhEnSHQWN/CIH/MLGaBaxxyuYlz/
         md2Sz5A/SmvEjvm5pzL7t6P1scm8clbUZr9LogMGlVyhAOGIdRzCo5q9fF9wG+62BuHX
         Hh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201513; x=1795806313;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oooEWJs9gjOAVhgIXEsvVmU0j/MFcc+cEdr5Tko/RTA=;
        b=V6/Smc13Ac/hfcbFHP7N/9pXQYlTD6nHv78lnB560nyVzlFq1jkZmoGCcIOorOfZXx
         q0n3oGbxz5YbVcApxZ6XqvWDRisXWfjDP7iMpmdRcNC6DbJsp3HQIJBYGbsqhfKp3OTk
         YhDDjdOaU42uL4UwOTokoo56/6jiAqlAaX2LQO7qpcRQPf+94aCZo4IFc5+R4hdH+wdh
         y6BJdrM9mcUWcwxY4JStifktTB/kz3FHTIgp3m3AoYBya9d630wJpzfTYceICXFilDCk
         Yld+xnAVL4nYaM+2i5JifyehYngiVfoxzcdSYyk2DOg6swPwMK0THvTgyr25MKf8l19t
         FwXw==
X-Forwarded-Encrypted: i=1; AL+hErGJQMWGurIFYvJBtZftlXRSwHr9eyOd3NGwwgDi4Jah6VbiaVsAcap58w1NnGdUqkPd0fR9cON288BbiX0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z818vbog1HEtilu93UB8Vau56AVAjBQC9aW5z96RKb/3HLXt1J+
	kFTkM56P/dkNSAlcIUSnO4gwYiAvosU+rZ2ndbrh6DBY3ZLAy4FwIpW7sxrkmRRxm8g=
X-Gm-Gg: AYBFou3INfgCNGD60X3+kqe3tDJGEdBhBnr/o+oBAZGU6GmjpC2MdcoKFMwiNE73nc1
	W/j28DnjLppsKPkn7mNtMbQ5WPOGV/wKs+MxAVHNP69j9jKKHimvQ1YcOkoGwaRClihWIDpWPBG
	hsAfO0wi84aQCaeK/SkijhZZVK+bKYhLiLt/4yi9sdxvByqCAvgSz7CxyLy51s10b2BSE3mPYfB
	///dDHxeST9aFY+5nJfzzU64+0AMBRhWf4xD72rOrerrNev4WP86Lm3jB4e2au5Gzk0G5+h3LOb
	pw83dPy8ryxqwD2IwoDG8T5GYmzOQmG64FUE7VRuwLh2u0RcP97KLX0xj+MbE0AgvQIHpKcKrTj
	DfEVxCgHrGL9kd/LJ2B/i14lyobha7I6qla3B0EJxGsuIikUrSQQn8fsOyCXXo42DabIB3k1vut
	xbBjGz/bX7VQaLoY+AF/h93El+09rAAuqT95E19UiOrRz/hr3ZdCDQnRWnDKRIiEgDVTJk9YMCz
	AX8Pk3z9jTy0PP81UwF3VBqASCeXxUhB9EX4y+nDPlpZNRPfSy8By6VdfmPCFtCZtWTm7hFL1t0
	KwkyS072kCBL+u0B5OsDugFGAjnmbPgGMX5I993keQFslhvHrFbZMQIP3+eJ8z1UPyorOZdqcDP
	HhBDbomEh9DUMgxVciLDFe5glJ+8=
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4bb88938a62mr93909055e9.28.1795201512760;
        Fri, 20 Nov 2026 11:05:12 -0800 (PST)
Received: from ?IPV6:2a01:599:241:b744:2c96:9736:bec3:7db8? ([2a01:599:241:b744:2c96:9736:bec3:7db8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f148aasm37911205e9.0.2026.11.20.11.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:05:12 -0800 (PST)
Message-ID: <f70eee05-1d17-4060-b1ee-f4845b74e3e6@9elements.com>
Date: Fri, 20 Nov 2026 20:05:03 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvmem: aspeed: Add read-only AST2600 OTP support
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>, srini@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, ryan_chen@aspeedtech.com,
 billy_tsai@aspeedtech.com, neal_liu@aspeedtech.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261113034213.158390-1-prasanth.padarthi10@gmail.com>
 <20261120174440.123487-1-prasanth.padarthi10@gmail.com>
 <20261120174440.123487-3-prasanth.padarthi10@gmail.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <20261120174440.123487-3-prasanth.padarthi10@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 6:44 PM, Prasanth Kumar Padarthi wrote:
> Provide root-only NVMEM access for userspace diagnostics comparing OTP
> ranges with vendor-derived reference data during BMC bring-up. The
> consumer uses raw offsets rather than named cells or a private ioctl.
> 
> Initialize read mode once at probe and mask the fixed secure prefix using
> an NVMEM keepout. Recheck SEC54 on each controller read and reject requests
> into an extended protected prefix. Programming protection does not block
> reads. Serialize transactions and stop issuing commands after a timeout.
> Use a 1-us initial polling delay and a generous 100-ms timeout.
> 

This is describing the code...
Most of it belongs in the cover letter or below the --- line.
Please explain what the *hardware* does and *why* the driver is designed 
this way, not what the code is doing!

> Adapt the read sequence from ASPEED's downstream driver, preserving its
> attribution, and add the driver to the ASPEED MAINTAINERS entry.
> 
> Tested on ASRock Rack B650D4U (AST2600 A3) with Linux 7.4-rc1 and
> OpenBMC Linux 6.18.24. Repeated reads, cross-pair reads and four concurrent
> readers (40 reads) passed. The selected 12-byte range matched a saved
> ASPEED-derived reference. The 7.4-rc1 run used a RAM-booted kernel with
> the working OpenBMC board DTB and initramfs; its final-pair check also
> passed.

This part should be outside of the commit message, like I explained earlier.

> 
> Link: https://github.com/AspeedTech-BMC/linux/blob/769f62b7baa84d6998723b0ea60280e380183553/drivers/soc/aspeed/ast2600-otp.c
> Link: https://lore.kernel.org/linux-aspeed/KL1PR0601MB3986A356BD06F98D0FF9AD5E80792@KL1PR0601MB3986.apcprd06.prod.outlook.com/
> Co-developed-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> 
> ---
>   MAINTAINERS                      |    1
>   drivers/nvmem/Kconfig            |   13 ++
>   drivers/nvmem/Makefile           |    1
>   drivers/nvmem/nvmem-aspeed-otp.c |  297 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 312 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315..5415e2be4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2813,6 +2813,7 @@ F:	Documentation/devicetree/bindings/arm/aspeed/
>   F:	arch/arm/boot/dts/aspeed/
>   F:	arch/arm/mach-aspeed/
>   F:	arch/arm64/boot/dts/aspeed/
> +F:	drivers/nvmem/nvmem-aspeed-otp.c

The matcher here *may* be unnecessary given that we have `N`.

>   N:	aspeed
>   
>   ARM/AXIADO ARCHITECTURE
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index d2f5bb236..e6445262b 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -164,6 +164,19 @@ config NVMEM_APPLE_SPMI
>   	  This driver can also be built as a module. If so, the module
>   	  will be called apple-nvmem-spmi.
>   
> +config NVMEM_ASPEED_AST2600_OTP
> +	tristate "ASPEED AST2600 OTP support"

The file is now named generic. Please name the kconfig 
"NVMEM_ASPEED_OTP" so it doesn't need to be renamed once AST2700 support 
is implemented.

> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say Y here to enable read-only access to the OTP data region
> +	  on ASPEED AST2600 BMCs through the NVMEM interface.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-aspeed-otp.
> +
> +	  If unsure, say N.
> +
>   config NVMEM_BCM_OCOTP
>   	tristate "Broadcom On-Chip OTP Controller support"
>   	depends on ARCH_BCM_IPROC || COMPILE_TEST

*snip*

> diff --git a/drivers/nvmem/nvmem-aspeed-otp.c b/drivers/nvmem/nvmem-aspeed-otp.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/nvmem/nvmem-aspeed-otp.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) ASPEED Technology Inc.
> + *
> + * ASPEED AST2600 OTP Controller driver
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/unaligned.h>
> +
> +#define AST2600_OTP_PROTECT_KEY		0x00
> +#define AST2600_OTP_CMD			0x04
> +#define AST2600_OTP_ADDR		0x10
> +#define AST2600_OTP_STATUS		0x14
> +#define AST2600_OTP_COMPARE_1		0x20
> +#define AST2600_OTP_COMPARE_2		0x24
> +#define AST2600_OTP_EXTRA_READ_PROTECT	0x54
> +#define AST2600_OTP_EXTRA_READ_RANGE	GENMASK(5, 0)

Please keep register offsets and field masks visually separate.
Usually you put the fields directly below their register, indented with 
an extra space. For example:

    #define AST2600_OTP_EXTRA_READ_PROTECT	0x54
    #define  AST2600_OTP_EXTRA_READ_RANGE	GENMASK(5, 0)

> +
> +#define AST2600_OTP_CMD_READ		0x23b1e361
> +#define AST2600_OTP_CMD_WRITE_MODE	0x23b1e362
> +#define AST2600_OTP_UNLOCK_KEY		0x349fe38a
> +#define AST2600_OTP_STATUS_DONE		GENMASK(2, 1)
> +/* Normal reads take less than 1 us; allow a generous bounded wait. */
> +#define AST2600_OTP_TIMEOUT_US		100000
> +
> +#define AST2600_OTP_DATA_WORDS		0x800
> +#define AST2600_OTP_SIZE			(AST2600_OTP_DATA_WORDS * sizeof(u32))
> +#define AST2600_OTP_CONF0_ADDR		0x800
> +#define AST2600_OTP_CONF0_SEC_SIZE		GENMASK(21, 16)
> +#define AST2600_OTP_SEC_SIZE_UNIT		(32 * sizeof(u32))

The alignment is somewhat inconsistent.

> +
> +struct ast2600_otp {
> +	struct device *dev;
> +	void __iomem *base;
> +	/* Serialize the complete unlock, read and relock sequence. */
> +	struct mutex lock;
> +	struct nvmem_keepout secure_keepout;
> +	bool failed;
> +};
> +

*snip*

> +static int ast2600_otp_init_read_mode(struct ast2600_otp *priv)
> +{
> +	static const u32 mode_addresses[] = { 0x3000, 0x5000, 0x1000 };

Please give these registers names instead of using an anonymous array.

> +	int i, ret;
> +
> +	ret = ast2600_otp_wait_complete(priv);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Restore read mode once at probe; this driver never programs fuses.
> +	 * These writes target volatile mode registers, not OTP fuse cells.
> +	 * No fuse programming command or programming timing is used.
> +	 */

All the sentences say the same in slightly different ways, but none of 
them says *why* the step is needed. Maybe: "Linux never programs the 
OTP, but it might be left in it before, so restore the read mode once"?

> +	for (i = 0; i < ARRAY_SIZE(mode_addresses); i++) {
> +		writel(mode_addresses[i], priv->base + AST2600_OTP_ADDR);
> +		writel(0, priv->base + AST2600_OTP_COMPARE_1);
> +		writel(AST2600_OTP_CMD_WRITE_MODE, priv->base + AST2600_OTP_CMD);
> +		ret = ast2600_otp_wait_complete(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ast2600_otp_read_pair(struct ast2600_otp *priv,
> +				 unsigned int aligned_word,
> +				 u32 *word0, u32 *word1)
> +{
> +	int ret;
> +
> +	/* The hardware reads two words starting at an even word index. */
> +	writel(aligned_word, priv->base + AST2600_OTP_ADDR);
> +
> +	writel(AST2600_OTP_CMD_READ,
> +	       priv->base + AST2600_OTP_CMD);
> +
> +	ret = ast2600_otp_wait_complete(priv);
> +	if (ret)
> +		return ret;
> +
> +	*word0 = readl(priv->base + AST2600_OTP_COMPARE_1);
> +	*word1 = readl(priv->base + AST2600_OTP_COMPARE_2);
> +
> +	return 0;
> +}
> +
> +static int ast2600_otp_init_keepout(struct ast2600_otp *priv)

The is misleading, because it also restores read mode.

> +{
> +	u32 conf0, unused;
> +	int ret;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	writel(AST2600_OTP_UNLOCK_KEY, priv->base + AST2600_OTP_PROTECT_KEY);
> +	if (readl(priv->base + AST2600_OTP_PROTECT_KEY) != 1) {
> +		ret = -EACCES;
> +		goto out_lock;
> +	}

Mixing goto and scope-based cleanup in the same function isn't allowed
(see the big comment in include/linux/cleanup.h). The same applies to 
ast2600_otp_read().
The unlock/relock sequence is also duplicated between both functions. 
Please move this into helpers (or a DEFINE_GUARD()) so it doesn't need 
labels.

Also, -EIO might be better here given that it's a hardware problem, and 
not a permission problem.

> +
> +	ret = ast2600_otp_init_read_mode(priv);
> +	if (ret)
> +		goto out_lock;
> +
> +	ret = ast2600_otp_read_pair(priv, AST2600_OTP_CONF0_ADDR,
> +				    &conf0, &unused);
> +	if (ret)
> +		goto out_lock;
> +
> +	priv->secure_keepout.start = 0;
> +	priv->secure_keepout.end =
> +		FIELD_GET(AST2600_OTP_CONF0_SEC_SIZE, conf0) *
> +		AST2600_OTP_SEC_SIZE_UNIT;
> +	priv->secure_keepout.value = 0;

priv comes from devm_kzalloc(), so they're are already zero.

> +
> +out_lock:
> +	writel(0, priv->base + AST2600_OTP_PROTECT_KEY);
> +	/* Complete the lock write before returning and releasing the mutex. */
> +	readl(priv->base + AST2600_OTP_PROTECT_KEY);

Again (as in v1), nothing else accesses the device during probe. This 
read is useless.

> +	return ret;
> +}
> +
> +static int ast2600_otp_read(void *context, unsigned int offset,
> +			    void *val, size_t bytes)
> +{
> +	struct ast2600_otp *priv = context;
> +	u8 *buf = val;
> +	unsigned int word_index;
> +	unsigned int aligned_word;
> +	unsigned int secure_size;
> +	u32 extra_read;
> +	u32 word0, word1;
> +	int ret;
> +
> +	if (!bytes)
> +		return 0;
> +
> +	if (offset % sizeof(u32) || bytes % sizeof(u32))
> +		return -EINVAL;
> +
> +	if (offset >= AST2600_OTP_SIZE ||
> +	    bytes > AST2600_OTP_SIZE - offset)
> +		return -EINVAL;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	if (priv->failed)
> +		return -EIO;
> +
> +	/* SEC54 can grow after probe; keep the registered keepout immutable. */

Please describe the hardware behaviour instead, e.g. "SEC54[5:0] can
only grow until the ARM cores reset."

> +	extra_read = readl(priv->base + AST2600_OTP_EXTRA_READ_PROTECT);
> +	secure_size = FIELD_GET(AST2600_OTP_EXTRA_READ_RANGE, extra_read) *
> +		      AST2600_OTP_SEC_SIZE_UNIT;
> +	secure_size = max(priv->secure_keepout.end, secure_size);
> +	if (offset < secure_size)
> +		return -EACCES;
> +
> +	writel(AST2600_OTP_UNLOCK_KEY, priv->base + AST2600_OTP_PROTECT_KEY);
> +	if (readl(priv->base + AST2600_OTP_PROTECT_KEY) != 1) {
> +		ret = -EACCES;
> +		goto out_lock;
> +	}
> +
> +	ret = ast2600_otp_wait_complete(priv);
> +	if (ret)
> +		goto out_lock;
> +
> +	word_index = offset / sizeof(u32);
> +	while (bytes) {
> +		aligned_word = word_index & ~1U;
> +
> +		ret = ast2600_otp_read_pair(priv, aligned_word,
> +					    &word0, &word1);
> +		if (ret)
> +			goto out_lock;
> +
> +		if (!(word_index & 1)) {
> +			put_unaligned_le32(word0, buf);
> +			buf += sizeof(u32);
> +			bytes -= sizeof(u32);
> +			word_index++;
> +		}
> +		if (bytes) {
> +			put_unaligned_le32(word1, buf);
> +			buf += sizeof(u32);
> +			bytes -= sizeof(u32);
> +			word_index++;
> +		}

Why not reading the pair into an array? That'd remove the duplicates.

> +	}
> +
> +	ret = 0;
> +
> +out_lock:
> +	writel(0, priv->base + AST2600_OTP_PROTECT_KEY);
> +	/* Complete the lock write before returning and releasing the mutex. */
> +	readl(priv->base + AST2600_OTP_PROTECT_KEY);
> +	return ret;
> +}
> +
> +static int ast2600_otp_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config config = {
> +		.name = "ast2600-otp",
> +		.id = NVMEM_DEVID_AUTO,
> +		.owner = THIS_MODULE,
> +		.type = NVMEM_TYPE_OTP,
> +		.read_only = true,
> +		.root_only = true,
> +		.word_size = sizeof(u32),
> +		.stride = sizeof(u32),
> +		.size = AST2600_OTP_SIZE,
> +		.reg_read = ast2600_otp_read,
> +	};
> +	struct nvmem_device *nvmem;
> +	struct ast2600_otp *priv;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	ret = devm_mutex_init(dev, &priv->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = ast2600_otp_init_keepout(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to initialize OTP read mode and secure prefix\n");
> +
> +	config.dev = dev;
> +	config.priv = priv;
> +	if (priv->secure_keepout.end) {
> +		config.keepout = &priv->secure_keepout;
> +		config.nkeepout = 1;
> +	}
> +	nvmem = devm_nvmem_register(dev, &config);
> +	return PTR_ERR_OR_ZERO(nvmem);

nit: return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));

> +}
> +
> +static const struct of_device_id ast2600_otp_of_match[] = {
> +	{ .compatible = "aspeed,ast2600-sbc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ast2600_otp_of_match);
> +
> +static struct platform_driver ast2600_otp_driver = {
> +	.probe = ast2600_otp_probe,
> +	.driver = {
> +		.name = "ast2600-otp",

If the plan is to add AST2700 later, then please use "aspeed-otp" and
aspeed_otp_* names.

Last: Please run your next build with W=1 and do checkpatch.pl + 
dt_binding_check...

Tan

