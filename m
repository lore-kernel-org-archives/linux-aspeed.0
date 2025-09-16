Return-Path: <linux-aspeed+bounces-2235-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6E7CAC59B
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Sep 2025 19:07:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRBHc5xfFz30N8;
	Wed, 17 Sep 2025 05:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758049676;
	cv=none; b=b9UvK2R3hNsYYmOqQyEqYIuMj5xlQ63W08q7hv1hnsSyqDjdPiijnabBtDazT5q5Xiwvf+dXthVI1NNpN4IfkafktkDwcpxiI6BoekVwpQETnFDxe6HbKTxMo3pacMJEJ9d9s+T/dP2KuD8aTmCDILhC2PswfngSO4skoFtWo6k/tM9CYINr43ENSoWkvmU5ozByFAsWQcma4LpuOICDqVnkIsVBjQBVoyr0Ie7VEO5OkJaRWo4diFfX/9i6t/02Pwn38p9RnytU8FUdnqWZvQ0bxMwyqWbowwNO1u/Yh0arBg1a6roCj+GAM4ppfjgjL6yl13Zc3GU0PRG4xjp7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758049676; c=relaxed/relaxed;
	bh=EXaqcsYENogvAnvlB2KNNelAI84J4RkeUSRS8e50eXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpzC9q+cpzXT0EY3GBnG8NwT9HS1dtvIMyegOujO7202f6XXtosdNzPVQgtH2PUpx2ykUdogJw4mabN9yn/+0MFwGkbIidBlUUq72siXwPdIcxl1jWgrswwV+6I83cTHe3C4kmZW8n6EJW4FtserdrEsbeNPEDr4gzcn/c8Aruh9hX9tVMNcdad+pTUH7hTu3BEyiLNFttqWr8gvcM3z3WN2KDBJwEBINkmW1qAXFctSLZDRTr9OwVpPVcegjllGPcrlIXCgOZkA9iYjjXT/ot3oM9TjnCkqE8Oc3G5fDeIT2SSpwlSvr2aghhgAwJ2/ewqP//Ywh4attBfsz3gNQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=L0qSGYez; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=L0qSGYez;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRBHZ4Cpqz2ygH
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 05:07:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EXaqcsYENogvAnvlB2KNNelAI84J4RkeUSRS8e50eXg=; b=L0qSGYez+AX/bZrlmzh1BNLW0E
	EtKNdzLn0IOSUqLJ95hkAkKr/WHGXbRVqtBgnw6ggf6aJDSJttdau3MVJyP/oD0PcpfSqDKX7qm0E
	CVa8efe7MTJIwxmBA6mnF+ERrenn5O8SrFw7wUx2vWKbMVm/U76tRW8JqQwbgcR5PZts=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyb1b-008bIv-HR; Tue, 16 Sep 2025 21:07:35 +0200
Date: Tue, 16 Sep 2025 21:07:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <3f5e82ec-d96e-4258-b117-9876313f5402@lunn.ch>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
 <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
 <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>
 <74e68c53-2696-4f86-97d3-c0b0a74d4669@lunn.ch>
 <92bcdac9-44b1-4fc8-892a-01ef0ed0b7e0@bsdio.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92bcdac9-44b1-4fc8-892a-01ef0ed0b7e0@bsdio.com>

On Tue, Sep 16, 2025 at 12:40:15PM -0600, Rebecca Cran wrote:
> On 9/15/25 18:37, Andrew Lunn wrote:
> 
> > And does it have a PHY? On an MDIO bus? Unless i'm mistaken, you don't
> > describe the PHY, a phy-handle pointing to the PHY, and don't have
> > phy-mode = 'rgmii-id'.
> 
> I've been trying to figure this out. Yes, it's connected to a PHY (an
> RTL8211E).
> 
> At the moment it's being detected by OpenBMC as:
> 
> ftgmac100 1e680000.ethernet: Read MAC address 9c:6b:00:43:0b:bd from device
> tree
> RTL8211E Gigabit Ethernet 1e680000.ethernet--1:00: attached PHY driver

So what is probably happening is that the ftgmac100 is creating an
MDIO bus. It does not matter if there is no node for it, it still
creates the bus, and the PHYs on the bus are found. You should be able
to see this in /sys/class/mdio_bus/. Then, since there is no
phy-handle, it uses phy_find_first() to find the first PHY on the bus,
and binds to that.

Now, it looks like all other aspeed-g5 boards also don't link to the
PHY. But the driver does seem to support adding an 'mdio' node within
the ethernet node, and listing the PHYs. Something like:

       mdio {
                #address-cells = <1>;
                #size-cells = <0>;

                ethphy0: ethernet-phy@0 {
                        reg = <0>;
                };
        };

And then you can add a phy-handle to point to it.

Then the question is, did Aspeed mess up the RGMII delays for g5? You
can try phy-mode = 'rgmii-id' and see if it works.

    Andrew

