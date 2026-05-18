Return-Path: <linux-aspeed+bounces-4049-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8A5CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 06:35:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJp2n53mJz3bwR;
	Mon, 18 May 2026 16:35:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779086129;
	cv=none; b=jxelwJ3OpsNMEaoD82sKSYcXgbn3lL5edaAmgaxpABq772/hulWy8ZP9JJ4bJ4m3HjLmMYIuojsHKcNU2n9tVAjdtKp392r9BXLMgvZA78gaOXZNAMTl4vyxa9euF/W872muQRhzW8IGXz0Mns5XELckYrBg9VKMvahmMUoNrYZPbgnqWdpe2rLhv3iLiV733valgUuvmDMTzNrVrDDFVt5uukhBRfecRA0K4o0zuQEOMLoszJvhoCBN5x+t8oT7RsiRN7ACzKhGJk5LZInyO8ZLeNztHSTfPL8612xXW8E0d5BIGVvBrsWd7/djnuZy2Ekqs5qcDlN1MnAndmrQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779086129; c=relaxed/relaxed;
	bh=OPLzR8oDPNN23goctM1doHC/4cQsRID+tuEaNIAs+wg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FO3jAx9h88ZYiwTSbVd+oLJTvR3nGA64j5UbxAuaBMD7vgqehhgC8qm4eal3dPXjpWS8NhvFRhiZR91q8Egb6uPrA8gn446bu6qbPFbSDmlqBDAHfeK1xvZ/eghhOZf26G6czMRu97q9ua2mD3qfLki6DCtqKfnZT2uKWwzv6I6phP1rwhhvrRcSBICgqdp1j8CNdyQXZ6y4fkQLyPOQfZvSWXRmG/GeM2xNSc0DpnE9vs+SdjSSICaxNWQT2kYnAP9UQssr8V+oeYLZ+nf2jxVMt/Qb/DiHTz31zktvuPD49+Aw6/ZXQg+HaUj/9UrMpiXaEZnbpmGUBS5xq+033Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RImyBGvE; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RImyBGvE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJp2m3Jl2z3brc
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 16:35:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779086127;
	bh=OPLzR8oDPNN23goctM1doHC/4cQsRID+tuEaNIAs+wg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RImyBGvE1qS7EIaiJ1BCR11W4L35QOSClxXJhV1IEvQbN1ApnxZo+nZitPkxA1/YL
	 XEp9iSRzH18Z00Aw4jK8FjsBf9AVnV/Y5mLoxdzWq/nfooixxNmmQoCy3IwcX9D+Wx
	 Dy5xBMrGFPBFlYImFB5wbNNCpqvBHA4oqUoVQ1QxGulrNGm2vxEIoTHNFTcHnurFg5
	 pX4lg+nZvR9GuWdcLrrvAGRMA1pIel2mpfyQhMfUxmpo551ZBWjsYpkEgEGqfUpcVj
	 4YKGDhwy4GPzuUy0lALTSdqsv8VLPvACasEZVATVX4ySRPj37K7LtOZJXaYZ+FJjxZ
	 r7Dvh98rkbHhw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DC8786025D;
	Mon, 18 May 2026 14:35:24 +0800 (AWST)
Message-ID: <5947248c99e14e59f10b707e7ba523985c7d875f.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/1] ARM: dts: aspeed: msx4: enable BMC networking via
 MAC0
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ender Hsieh <andhsieh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Andrew Lunn
	 <andrew@lunn.ch>, Marc Olberding <molberding@nvidia.com>, Jacky Chou
	 <jacky_chou@aspeedtech.com>
Date: Mon, 18 May 2026 16:05:23 +0930
In-Reply-To: <20260505050541.3031447-2-andhsieh@nvidia.com>
References: <20260505050541.3031447-1-andhsieh@nvidia.com>
	 <20260505050541.3031447-2-andhsieh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Tue, 2026-05-05 at 14:05 +0900, Ender Hsieh wrote:
> Add &mac0, &mdio3, and the ethphy3 PHY node to enable BMC networking
> on the AST2600-based NVIDIA MSX4 board. The PHY is attached to MDIO3
> at address 2 and uses RGMII with PHY-internal delays.
>=20
> These nodes were intentionally omitted in commit f28674fab34f ("ARM:
> dts: aspeed: Add NVIDIA MSX4 HPM") at Andrew Lunn's request, pending
> clarification of the RGMII delay handling. Following his guidance on
> linux-aspeed, the bootloader has been modified to stop enabling MAC
> clock delays on the SoC side, so phy-mode =3D "rgmii-id" correctly
> results in the PHY adding the required ~2ns delay without any
> double-delay from the MAC controller.
>=20
> The corresponding U-Boot change has been submitted to openbmc/u-boot.
>=20
> Link: https://patch.msgid.link/eac09481-0ba1-4ac2-ad8c-d859822ff0d5@lunn.=
ch
> Link: https://patch.msgid.link/20260504044702.2613879-1-andhsieh@nvidia.c=
om
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Marc Olberding <molberding@nvidia.com>
> Signed-off-by: Ender Hsieh <andhsieh@nvidia.com>
> ---
> =C2=A0.../dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts=C2=A0=C2=A0=C2=A0=C2=
=A0 | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20

I've applied this to the BMC tree. I've also applied the linked u-boot
patch to openbmc/u-boot, and backported this change to openbmc/linux.

Cheers,

Andrew

