Return-Path: <linux-aspeed+bounces-4758-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E197CC5B572
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Aug 2026 14:02:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ7Z70rDHz2yXm;
	Thu, 20 Aug 2026 00:02:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787148175;
	cv=none; b=f/Eh2yTZVsO5HfdFg0ZD3lIw23MAn9yMD5F1zwslVY82U2+XQURljw9PpVQ2HzcuvMLqSelp1vLNVbnxmqCZq8NCr+NSBzRN+38F1HQkqukocJtzbgzVyDD6WdtXYs4OOkf2s1BIGYxnbcXEwcgUhjBwFFYDQugcVyVjhvXC4QsXBESswbG48MkM5Kw5HsvtXWp8bMXLfrE8oHDU9C+3Xhgm33rcfO3tnruiX37ZEeaIp/kVaXk3HU5ei+iYu0U7XpbMFuiKmljhMKfnJVNRV3oKjcAV7715mEFde5+MP1KWfBLKKLmC2yChZGiWYXgi7AC8LId78Km9epNuGIjAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787148175; c=relaxed/relaxed;
	bh=Co7HS0jVxwA4gYnxXevJyYoop6np3ZD8A3AJ6SheuSI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UsUD0wmVjlsqB3psW8kj4a/HCwIncBI0M99HlDzITnt5LWxVMO1oHddNSSnVCbqYWFYsK2T8nNCR2msxjsxlrVKMZAorywfmkaMf8ri41fbl/5nyj+JOiP9ikmo+7ZkuLj1/VHQN/YaFABv1OPXXwwuaJY0bHKuxP9DIPKyTuQbk3gv1vL+7jcMquAvW1D0207D+S1krWM/2oFQRb/y7dzklxsseNQ7xVXUFu89e/ppBLGSUQVoZNZeFDsGV5O/pHKXFIuK9HBCnpAh5pJas/1Teus4MgzyGuJmtsp0EXCy0Xl+ePTr/epBUwJ0jP4omfOQkZ7zyNf3K5zoEVRF1eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=CGwBsflg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=CGwBsflg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ7Z60k2Pz2ySm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Aug 2026 00:02:53 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4994c49f588so10953055e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Aug 2026 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787148166; x=1787752966; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Co7HS0jVxwA4gYnxXevJyYoop6np3ZD8A3AJ6SheuSI=;
        b=CGwBsflgOmu6Bev8mCW0FrAv4m7TL6KXZ/aFrSOpIVDt/UXZEcTKpkkBfW8KXUWMOX
         QHikP6OIpPaVeJVinGlnwRTEjlALIBedxdja/zpb+Jfh9ml7jvyZ3aewxRBN5WrYaCk7
         CSVPGQoZESQsxK980vd/NJ7X5l+Y5A+vsqqDI/W/5vB62tNPqCAdTDlFFB0mnxvM0G7b
         Ioz0+a5HtUjdqWqGvVuvh/PuvWLKjy9oPmg4xuDz1Pi1yz27i9CtYN1oGYSG4Q/dKxw3
         pAjhcSQLZcSdvAhk8kde7Ybb/rMi5ydUKaelpGzOiuc3R8us0416wnJwyRUpjSa5dk6U
         i4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787148166; x=1787752966;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Co7HS0jVxwA4gYnxXevJyYoop6np3ZD8A3AJ6SheuSI=;
        b=DvIMJH6ZfYZh6y5lwYZllKpYKifZ/5Fmba9O4zbRfDvmuUgNgUk6VWrbrF4QPMGSMJ
         P3YPNXP4sxo0a3a0ax6Q7Tla3MHCGDFJ60HksLeWNSlDL58hfsFF0WbF9KJBtXmvikjd
         hTj0oQTeURwqZDvjWgiENnJT7dwg/Fw/8g7yX3XtUGdJVa4TfAYP36BxkR1LqNz/1FQf
         lPqB1UFxhK7ewCnPH1BoeAzZKaOJKknFW1CJIIMRRs1xjWzmwJa7NmVWVuh5gbXPSUJ7
         575LQ3Yq6FwOhsNRld0Bg5tNq5vVHlA8zpipUM1zZQpZUxvdW/xu9piBltILIqjeTtlk
         9lbg==
X-Forwarded-Encrypted: i=1; AHgh+Rrh/6Y4LuHzwBqsvjKvhgbesrHiWjPxSiWExaFxltzJUKBbK8Pys4cE+GF44v93EOYfi3hLogM++tpxQuw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyq6OR52l7GzEw8xXMGA77FeavjdCbilf5iFP9FlOYSDKmgdT1K
	SpIRyY8fhu5OL2JZq2weGuKWC8E1rTKlHWeWDbOfB2gxu91WQIpBsJHjXjpsTj6jYWs=
X-Gm-Gg: AR+sD10ipb693GzLYFC9/IpQwL7SF2LGVjonmTY4sgKsSFFAkJVr9pW0lozjI2FqRm+
	sN/XAr+Mak919EaJBqXeB/dpPXXMC+N+OcmuuRNzDgYt6sDZDJUKOIWSXdgdJWT4qA/2YcQajSG
	OTMjRQojC6KqsZQLdWB2DLoVaBj/rrAfzxTFq89DtM7TkyWS+eYjQpDtSlL2jLW0KdCnjOYKJyX
	4dSPBPlSkmMVfSQFBiHAyy2iYlweFpNke2O/yqIpOj9d7PXd3+wDEGs/bANFYq6TfTXw3jCvY/n
	CLqtSOmqYP9qkYkIJC+J3mBOXOi2dn3+JYNJP93sdQDCz66AaR6IO3VfDwWxiPT95jqHyHuwXTZ
	3LdjS8C7frIo8GLXmjsldaB4YnVdS0iVDTqVDTOcJUGBfcN1nj4TTzHBZQsg6ZaWeTObnbucIJJ
	PvSczXG8pUSRUy1G+2IFBBJwfCvlCA43elJVBxKOY73h/iQR3d2q0nigRC+i/jpaIuigPvN+vax
	sZJp2c=
X-Received: by 2002:a05:600c:528b:b0:499:8d9b:832c with SMTP id 5b1f17b1804b1-499aa0e816bmr89871925e9.4.1787148165591;
        Wed, 19 Aug 2026 07:02:45 -0700 (PDT)
Received: from [10.0.5.39] ([2a01:599:445:d261:4474:9672:b73d:5481])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1111a7sm65896975e9.6.2026.08.19.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:02:44 -0700 (PDT)
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
Subject: Re: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC
 device driver
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>, 
 yh_chung@aspeedtech.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Lee Jones <lee@kernel.org>, Tan Siewert <tan.siewert@9elements.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, mfd@lists.linux.dev, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
 <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com>
Date: Wed, 19 Aug 2026 16:02:33 +0200
Message-Id: <178714815308.32179.15619694497271022262.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787148161; l=2564;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=0DLSrAiTsD+9mc3Vb7d5/lW0XmN5KPP+fle4/Gx9vJg=;
 b=Yv6DuRVXQ2eVIdd6FJVizmL+OmzjHQrDLg4pQ5mdXCZvnzUvsviM6pk+86GADUkAh8FQzylEb
 nvtlCfTGTCeAPv5Md2UT7KuGRs+InVgjAh4bWM68kaHE79DwTv1qQZ3
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

Hi,

On 8/18/26 12:29 PM, Grégoire Layet wrote:
> Add support for UART over PCIe between ASPEED AST2600 BMC and
> host. This is the host-side driver.
> 
> Based on ASPEED 6.18 Kernel SDK and trimmed down and changed to
> MFD driver.
> 
> The AST2600 has two 8250-compatible register set usable over PCIe.
> These act as two UARTs. As there is only a FIFO internally between both
> ends, they are called Virtual UARTs. This patch adds both VUARTs as
> plat_serial8250_port. This is the core driver in charge of setting up
> MSI interrupts. It doesn't bind the whole PCIe resource to allow each
> sub-driver to bind the needed addresses.
> 
> This is not added as a PCI 8250 UART device, but as a MFD driver, as this
> host driver can be expanded upon for IPMI over KCS. It can also be used
> in the future for custom BMC<->host communication with shared memory and
> doorbell.
> 
> This host module should be the entry point for setting up all features
> related to an AST2600 present on the PCI bus.
> 
> Notes on the implementation:
> The host can't detect the VUART addresses, so they are forced to
> 0x3f8 and 0x2f8, as in the initial ASPEED driver.
> 
> The MSI vector index of VUART2 has been changed from 15 to 17.
> The index 15 used in the initial driver was not working.
> 
> Tested:
> Data path in both direction is tested on both VUARTs.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>

I didn't notice this earlier unfortunately, but this Sign-off is invalid (I don't
think that "aspeedyh" is a real synonym), see [0] as there was a similar
discussion. The same applies for the patch "serial: 8250_aspeed_vuart: add VUART
over PCI" for this series.

@yh_chung@aspeedtech.com: What is the name that should be in this sign-off?

> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15011f5752a9..33a0351819e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4011,6 +4011,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/crypto/aspeed,*
>  F:	drivers/crypto/aspeed/
>  
> +ASPEED PCI BMC DEVICE DRIVER
> +M:	Grégoire Layet <git@gregoirelayet.com>
> +M:	Tan Siewert <tan.siewert@9elements.com>
> +S:	Maintained
> +F:	drivers/mfd/aspeed-pci-core.c

I think it'd make sense to add the linux-aspeed list as `L` here.

Tan

[0] https://lore.kernel.org/all/3f2d964a-4e82-414c-b373-af0d531b0fcd@kernel.org/

-- 
Tan Siewert <tan.siewert@9elements.com>

