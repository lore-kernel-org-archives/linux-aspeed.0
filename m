Return-Path: <linux-aspeed+bounces-2347-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A53CAC5B5
	for <linux-aspeed@archiver.kernel.org>; Fri, 26 Sep 2025 00:03:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXrQJ5Mz1z30Ff;
	Fri, 26 Sep 2025 10:03:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758845000;
	cv=none; b=oYuNY0FUhSVkqGukwVudW7jeYRPn8gD+PPUBsK473oIBhkrAgWAnO5W60q5k0O2UjdA8reUlUzdvEotMhbOwwSfs4ci0BTneHjR0Q1wodSvv0EYLhcCMHaOYE3+SANPuD/ezEqq/0bJNbTWJ4tA/28oiZLrNLdsLqT4AVCV9v+bWnDKV/nsNMTLBDevSPYpCnnGQ/I2BjsJI2gfu1tjpQWtj2v/OJ9TMlUY8Mw55FFal2pL+TCVBwn1XVeCFCUk1CZ9FLLieGmy2PMQfuEKwW+cw6b/lGPuFcnsfJTB1+OwlB+UpdUh+ZD+bo3alQzb7oTdm8a5GpkAgyQoAF836Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758845000; c=relaxed/relaxed;
	bh=/mW/nMqfIINnTqRPHIbmcypX5XTwPU5MVHd9Yju9OeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGuBVLzCUknCw4P2IprlLIF0wbV+zz2FfMOMAMTb62+URGz2QrRoQbqwcx3ohjUHbW0pZSCtLpyD9KNN6CZS8pqUjD0QutziQKlK14L4H5piUwfkVscN1tpA+dLbf8ALAB+/Sl1I14ygUpFeMpXeZg35941Z6PrE+Nzgi4LM2RHcYo5iLKS0RriVUIv3joQ0e/xsw3XKMM/bK/PzXm5vaaC5Ofy1ZkqFJIp0NqDCdeDoIhxwj4G3Mf0ppsc25x2f+4fxwbUz9Eirza4djscJ+cPuzC3AdnEXHYFizpPyO9axvQlcfUfJKbXWIPwAxoYCBAeglhS7cxAKiCm/Xkfp5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FYCus1px; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FYCus1px;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXrQG4mswz30FR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 26 Sep 2025 10:03:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758844996;
	bh=/mW/nMqfIINnTqRPHIbmcypX5XTwPU5MVHd9Yju9OeY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FYCus1pxhNLWLD/s3NS2zTUyXoADRdH2hShYJBRBfargpAOJpnBB4SjkFx96o2w8i
	 CmuumwgXmE4O7bdW8BZvI1qk3BtyC1zICoEm34d5ItCtrMF0q7xThq0Sh0u4Z/icSp
	 1fij/JVX/FxqsvJQonnitwj0InMJ1Arzn3YQir+V+mOZoooe3OKIbK9DXCOwchqwyx
	 X3RmnHlyLz0FjOpiXOYy+a2b0BvnAX8stH84qWwHNPZzm298MSkGrCUKJW7g3SojEh
	 V6Bj6SrqdarzH8dI7igYL03t4cTV49jA+WKn4JjPJ9WDaY/MDS5VVD89B4NIcX73VO
	 HKu/8v8QjDSmg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BE2BC64743;
	Fri, 26 Sep 2025 08:03:15 +0800 (AWST)
Message-ID: <6d117ac3297628ee6e315894460d348647b68c7f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 6/7] ARM: dts: aspeed: Add Balcones system
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>, linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org
Date: Fri, 26 Sep 2025 09:33:11 +0930
In-Reply-To: <20250922175804.31679-7-eajames@linux.ibm.com>
References: <20250922175804.31679-1-eajames@linux.ibm.com>
	 <20250922175804.31679-7-eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Mon, 2025-09-22 at 12:58 -0500, Eddie James wrote:
> The Balcones system is similar to Bonnell but with a POWER11 processor.
> Like POWER10, the POWER11 is a dual-chip module, so a dual chip FSI
> tree is needed. Therefore, split up the quad chip FSI tree.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-ibm-balcones.dts=C2=A0=C2=A0=C2=A0 | 609 =
++++++++++++++

Looking at Balcones specifically, there's still an immediate concern:

   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: pressure-sensor@76 (infineon,dps=
310): '#io-channel-cells' does not match any of the regexes: '^pinctrl-[0-9=
]+$'
           from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#

On the whole though it's much cleaner than other IBM devicetrees, just
the DTSI warnings remain. I'd appreciate it if you have some time for
cleanups to Rainier, Everest and Bonnell, the number of warnings is
really quite large :(

Andrew

