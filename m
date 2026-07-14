Return-Path: <linux-aspeed+bounces-4473-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88FDC44507
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jul 2026 18:53:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h07jj5C2kz2yRl;
	Wed, 15 Jul 2026 04:53:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784055193;
	cv=none; b=SEcnxUwvkzsvWx9kh5XyAdHBk5cOLghk15TWTjd2aDH89CijEi1T2MJkxiJP6kAvsLrdHtUHIYpf4kD55q2HHX/ZNDezcAahAi/OZOQFWRN/HmWp2MI5Q3qO+kFCrEv//pz8YVFCMmJo8Af2NpGs8qTojC9zXsJMpsjVL8xVnJvwLXc0B1tbdyf4TZOFb6EBpt2RSX+1t6K6Py9eS04lRPLf68fY87lQ3bZWa+ygztXIVJHRfdXxGJq9NhNt2ImM3bROnmcekv5qG2Nx1zQhjYZ56DuwowPLqigNsWpdIyXpei6oJH0uke2PZqZsWgPv6NYEqpELsnmYUb5Qp5qt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784055193; c=relaxed/relaxed;
	bh=v81RYgZzr05KCDxoR1cyj6HFcz85Vml1RF/7JkwpDYw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Q8xOISlgmZmT49vz0hF7Dy6/+JTPeZYwruQULbD7pf/l7uFgVPgvEO5hQNO1X5LL7cYON76rnVGFEHjmrJbXxyzVOr/zIbifKthMdAzqjrD9qbL7XvzzBARDxz+/JGX4mlbfAxxVw4ODFZj2KvJZk6G3D82EKXGW0s3swWLVgijnrSiP1ylJB6eIx++LmJoBoGkcCmlP2+hqluA30G7wtmhwgNeB+vauUn8qYjrJf1rIR505J3Nbs6zrznjJmWJ94Z5WnH/KkPc9/VMAQyK14yyvM78wLapqfTqD+MwQCBKBADht+ObB3VSq0PzoCntvxIaTZwH5aLEToV0b1MdgSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=FYJnku9z; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=FYJnku9z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h07jg5v0xz2xqM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jul 2026 04:53:10 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso35733875e9.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784055187; x=1784659987; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v81RYgZzr05KCDxoR1cyj6HFcz85Vml1RF/7JkwpDYw=;
        b=FYJnku9zL4f9hYZpGgboQ0PKMS2iRRwWrdrCIUWExzZbP+6Ek8QqV1fwwbOXu/pSSN
         UT4K5RZYLmKjutxODpJ3qXB6r1LItyYvZP2TehlydAgfLk/6sIOymJpZhzwpW4GJiT+R
         +zHiiZiLGD0U+v9ltbOLZ2ikdnrqQSwbQ6aUoC0iG3dH10Q3PYtWfY2ZArp50CZb1Vl+
         aQMOUplAHiQEVW5HIvaXJZ4S1OgcYdBxkSCZsvWFbh8XnGum9Hk/pUz/YQ4Bsl0a4nZe
         Z6ZHj5MGei03dcpZePDPu7M7eOSdi2rxrRpJq/FYF8177j1egmhAoGNEqPhljMqKKA9b
         rNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784055187; x=1784659987;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v81RYgZzr05KCDxoR1cyj6HFcz85Vml1RF/7JkwpDYw=;
        b=rWmX2g8H2HFNIfGcafB0HxhLlysCukfkyTtQB+gPORO47F5yR1PHQjvtVCcktJeJW9
         aPZfZPFZvM/QLhaQfN2SztyDLB2ae1ZwJr7H8DNTQ2koQdedoZib2NcVoxYSkylfzJWA
         hNzpgt1Pq1NI94khJocoGA91zNfzk9A7t/iGPSvYWj9HaE+wpjtsbgVANAn1pVWSzjb1
         QaA6M+By5Qzi57doP9qnhahYuok84v9vnMfCMIt9j17zW5Gu7LDosPezXoDvjuqw86cy
         6Kg5+fUfejW2ASey/KnUr5GYHUQtLvNvyYLuyxVL7Z4bPN8ZhGjrtuOsUVhzxC6cht5S
         kLGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rou6ow/jFyZBTRpWGAHlF0WL4JNEIy0GRWFSUvbif0oBXfCpAydv9Ue8T4pmvAmEt5O/EIpxzFAJkdaMQw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzqclc7Ro1ZNhT5zorTGK39RH/cTqHyNMACQ48c7z3YraWTY8ew
	wCz2esNt09isQPmnBj6SzV6NXWQtRcNIEWuq6yJg2nzKxjW55WZcBpGkl//lIORCPG8=
X-Gm-Gg: AfdE7ckApTVlUMzQWbMkAlRUIC/BXf1dSj+3+bSJ7feMvMRHpwCY+Zff9Oc50xvFnK0
	qcSwwgpY/9wfe0mQbopWlHUxRpp6GErye8TkKTrZ5YoAGTQPwoeyU6c0g4eMo9aUuV1F7Ptqvja
	6EdaUVGMC8eUf5hmVZLAo3XBXWqnjAY4+3NRUUxLCjcg5g/QsJyn6Gh2g35dNii76S7WwNFplZ8
	jkW2f/7PKYxxhCmW22AchAgrPL5Vjn9vdmOYEJFhxOlY7e0JWgO7NdOoi0ys1YNqj5VTJd2Meh4
	nYK+7Inlf1pDIEd+NeopKHz75GDOp7lsCXfaffuG8I8l7xs1tbzHRtNnAXyzRsLsf2eaVkd7PUM
	fYtU6k6wo1/cME8gOQiDkIUiR9Hd3sJF4zfZtuZhQQvrGilg+KyFZlG6D63mlTzDKPNt+4pU8Kg
	UDEYrpWqxPwMMa6fSZi1agr6ap+IUrkg==
X-Received: by 2002:a05:600c:3150:b0:492:53e8:3bc1 with SMTP id 5b1f17b1804b1-4953c1624bdmr714135e9.17.1784055187650;
        Tue, 14 Jul 2026 11:53:07 -0700 (PDT)
Received: from [192.168.254.124] ([2001:9e8:2fb:8201:c26a:83ef:161a:409b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508725c0bsm94908715e9.2.2026.07.14.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:53:07 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 20:53:03 +0200
Message-Id: <178405518337.194693.16062290686593842402.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784055186; l=4160;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=ZdMjtjALJ9INUjixbUCM2kZrdun7GikDbIME1A+PLD4=;
 b=GZ6jzOrhucR05WwmvOfO9a6YYLoB752Rjv/H4tteyWXK0nQoP0J4vtOVuXDGA+QefmBBarWe8
 Ma1Cg3Obz4gAvCucwwSYpECAuo9Mbmv2Y1RTdL+yzoGUgXHEqBazp7d
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Enable the VUART over PCI for the AST2600. Activate it only if the
> 'aspeed,vuart-over-pci' property flag is set on an
> 'ast2600-vuart' compatible node.
> 
> The AST2600 has 2 VUART that are usable over PCI. These are already defined as
> the VUART3 and VUART4 in the 'aspeed-g6.dtsi'.
> 
> Sets the BMC PCI device enable bits, sets the PCI class code to
> unassgined/device specific, and configures MSI interrupts.
> 
> There is no disable function. Removing this driver should not disable
> the BMC PCI device, as other drivers could use it.
> However, if all the drivers using it are removed, the
> BMC PCI device will still be activated, which is not ideal. But in reality,
> this is not a use case for a BMC, the drivers will never be removed.
> 
> This is useful on PCIe BMC expansion cards that use the AST2600, such as the
> ASUS Kommando IPMI Expansion Card.
> 
> Register initialisation taken from ASPEED 6.18 Kernel SDK.
> Add return code checks to each register write.
> Simplify the code and add macros.
> 
> The ASPEED_SCUC24 regmap update is missing a macro for 'BIT(14)'. I was
> unable to determine the purpose of this bit. In the AST2600 A3
> datasheet it is marked as 'reserved'. It is only used on the other
> revision. As I only have the AST2600A3, I was unable to try this code
> path. This BIT14 was set in the ASPEED SDK so I kept it.
> I can remove it and the untested path if necessary.

There's not even a reference in the datasheet changelog, so I suspect that it
has always been reserved.
I'd be in favour of removing it.

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 6afa2f4057e1..4d09c04cb972 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c

*snip*

> +static int aspeed_ast2600_vuart_over_pci_set_enabled(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 silicon_revision_id;
> +	struct regmap *scu;
> +	int rc;
> +
> +	u32 pcie_config_ctl = SCU_PCIE_CONF_BMC_DEV_EN_IRQ |
> +				SCU_PCIE_CONF_BMC_DEV_EN_MMIO |
> +				SCU_PCIE_CONF_BMC_DEV_EN_MSI |
> +				SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER |
> +				SCU_PCIE_CONF_BMC_DEV_EN_E2L |
> +				SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE |
> +				SCU_PCIE_CONF_BMC_DEV_EN;
> +
> +	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> +	if (IS_ERR(scu)) {
> +		dev_err(&pdev->dev, "failed to find SCU regmap\n");

dev_err(dev, ...) instead of &pdev->dev (defined above).

> +		return PTR_ERR(scu);
> +	}
> +
> +	/* update class code to be an Unassigned/device specific class device */
> +	if (regmap_write(scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000)) {
> +		dev_err(dev, "could not set PCI class code\n");
> +		return -EIO;
> +	}
> +
> +	if (regmap_update_bits(scu, ASPEED_SCU_PCIE_CONF_CTRL,
> +			       pcie_config_ctl, pcie_config_ctl)) {
> +		dev_err(dev, "could not set PCIe configuration\n");
> +		return -EIO;
> +	}
> +
> +	if (regmap_read(scu, ASPEED_SCU_SILICON_REVISION_ID, &silicon_revision_id)) {
> +		dev_err(dev, "could not read silicon revision\n");
> +		return -EIO;
> +	}
> +
> +	if (silicon_revision_id == AST2600A3_REVISION_ID)
> +		rc = regmap_update_bits(scu, ASPEED_SCUC24,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
> +	else
> +		rc = regmap_update_bits(scu, ASPEED_SCUC24,
> +					/**
> +					 * The bit 14 is reserved in the Datasheet.
> +					 */

Even in the oldest datasheet that I've got (which was for A2 apparently) it is
marked as reserved.

Maybe some ASPEED folks can enlighten us what Bits 14 till 16 were used for on
A0-A2, and if they are relevant for PCIe INTx/MSI routing on the older silicons.

	Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

