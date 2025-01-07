Return-Path: <linux-aspeed+bounces-343-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A0DE77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 22:54:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSRFX26yCz2yD5;
	Wed,  8 Jan 2025 09:54:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736290480;
	cv=none; b=Xn4y3bmuWdy3kdNuzQoLYbyycOe7t0pdaihD9kMM3Vy43kOn0wp2fBdBitIiguxAPB8Ubgri8Y54dKLP3YXcS3Ey5424Zql1CHn7blU05c7qeqbcZjnAcHWLT5ndQLRgMzYcE5kwEoL4kwoKi3sdlDJCAOdgYXbjWN52Z2wGD2/CEFPLwNXqNKjEOgxLEGBXkfNLVNOtr164y8dmm5zL+jCe7TAm900Nl3h6pBy3QYFemyKiFbuo/gvph+OJ3zVV/teCGQbxOsJNrN0Q3o5M7HNsI9sn8vDmFQoTzELW09pP9gGuF4TqQVzs9wq4hx8uraF85isqJN4LAGgxOjTAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736290480; c=relaxed/relaxed;
	bh=vLc1xPAL0AFFKPRpUd/UVHpL4aDbiIngxyJwJEuzDb8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=E6QpaHEF5bBmE0Ih3J4b3kU7E49KnV29C5JWeG/gnECDmPZrVcn7bk6Iyxqw4/0aFrcexU2vXM1qrAYnjcNcODWG9gys3xBvE4+pBMClQlCH7AgtVHnM1cuMHC++Ktg6XURDi6ORahuTGDHPmhru45XEM7slHGBWiDS1tI7er5ECWo8PSW3IS51n44lMEoq62ybwPIpZL5rIoaWylTCCPrJfqm1aSCvCPn2Wgyc4EZWdSRT+bQCg485hgg446dM+7Z+R5V8NteRUpLjZY3lk32idZCZzBYJ+M6nkW8IItjXwkiJvxSW6SANDTAMH2O/A8qoj0QAR0HpWB7HBIRSLdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LJf7DYF3; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LJf7DYF3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSRFW2jqLz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 09:54:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 04F595C62E1;
	Tue,  7 Jan 2025 22:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A7DC4CEE8;
	Tue,  7 Jan 2025 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290473;
	bh=dYbF7CHxuuCz2p1jW22Ix5UW0UmrzVjjqtNsyO8jekA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LJf7DYF3n6cj3pBXooqWfWIUfMxkpq+W8jkF9sAjxC7pNSYms7tQbAQ9ZcS6HULtp
	 0zn6w2Tc9E71TTX19KpDZYeTBMbyqAiqX2S2Hu2uRHXmrV9YkPRDjDDNT/YZ1iRyd4
	 RLWfGOKVsiMoPJvQRWNbHSvi/WyUkvIUR0W9UWq+Ssg6rulAXGwW9oOaNlIbp5xbVs
	 GIdvbuuIr+Us+G0Q9045WfDhoZpZSlHpNytlG/in7WZGCnMGerIXzvaP7nnHXaiF48
	 NZgt0JQEE54lkJtYijy4F9cjWTwzJLBpQqXxWrX4oRw5Vn2gv8MXAoVIprSD0SS09a
	 rRKbWZgYVdhpQ==
Date: Tue, 07 Jan 2025 16:54:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, krzk+dt@kernel.org, netdev@vger.kernel.org, 
 davem@davemloft.net, andrew@codeconstruct.com.au, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 ratbert@faraday-tech.com, minyard@acm.org, andrew+netdev@lunn.ch, 
 edumazet@google.com, joel@jms.id.au, kuba@kernel.org, 
 openipmi-developer@lists.sourceforge.net, pabeni@redhat.com, 
 eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
 conor+dt@kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250107162350.1281165-1-ninad@linux.ibm.com>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
Message-Id: <173629037049.1994533.7630339914217766401.robh@kernel.org>
Subject: Re: [PATCH v2 00/10] DTS updates for system1 BMC


On Tue, 07 Jan 2025 10:23:37 -0600, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch set.
> 
> V2:
> ---
>   Fixed CHECK_DTBS errors by
>     - Using generic node names
>     - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
>     - Adding binding documentation for IPMB device interface
> 
> NINAD PALSULE (7):
>   ARM: dts: aspeed: system1: Add IPMB device
>   ARM: dts: aspeed: system1: Add GPIO line name
>   ARM: dts: aspeed: system1: Add RGMII support
>   ARM: dts: aspeed: system1: Reduce sgpio speed
>   ARM: dts: aspeed: system1: Update LED gpio name
>   ARM: dts: aspeed: system1: Remove VRs max8952
>   ARM: dts: aspeed: system1: Mark GPIO line high/low
> 
> Ninad Palsule (3):
>   dt-bindings: net: faraday,ftgmac100: Add phys mode
>   bindings: ipmi: Add binding for IPMB device intf
>   ARM: dts: aspeed: system1: Disable gpio pull down
> 
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  42 +++++
>  .../bindings/net/faraday,ftgmac100.yaml       |   3 +
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
>  3 files changed, 163 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250107162350.1281165-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#






