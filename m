Return-Path: <linux-aspeed+bounces-2879-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BECCCFA1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Nov 2025 13:20:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d63t95BmMz2yv7;
	Thu, 13 Nov 2025 00:20:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762953617;
	cv=none; b=Uu5Pv8X2bRM2q/ofmzRrbv4Y1VabOoDaTzF/jo/7PWIbbWc2Ln/E+BcQAnAVZRXcrsfddCPbjiCwHixqyWoufwolVgmHFuebaERjuC6QjPEdyLGOTB0sz/CVmEvtL8lNBL0m6XeRB/X9+8Ycuo+Brs1OgtJYCxA46B3VeKa5V62TM8MVThUUFQMc9Sm83FBtehrxz0EjtedfQXBM3kMJ2Jp2YOVajgyMPBVSt4Qv559MvmTNET5jq3HWcJhGu0WQ9IW++Sopn96xeLe6+/f4kZyGDBV1tZhZ1mmU9KmYDqRSPxg2RUq7ZUwAzf1YMuGaCTT+QT/Qp0JS77VT3xZY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762953617; c=relaxed/relaxed;
	bh=xu5J2YUVmO+KaIFCwe3YTQ+9UN97u6v/RSU7wP6bNI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNGgrvbC7sF0eHAaqVkgjKO8No0ykN7vvWG6IAlL7WzWz6IFnlwAdncNTfcQvmuIfIdcnl7Fr3F+zbmwedfgpQO3aw6+aiR+vTzRn663mwxwp8KDtTyobcoLnq7ZKs3O0N0B5TIs1HG0ZK32XQsWyIR21jSHFsIa6oZppFl9ZSZ5fGxRm+XA0o07BsI+0KcYrm425GKiLbTaCGOp2GG+UFbHrv2sEocNFCXOC48aZg6QYP6KVLSbstP8aHgdMGvSVKl44fAu7IZB2phGQ0abtsCKKHWCIozzkINEQHUfzMZEEksPqrmFGyPIZ8kO6Jtp3YSIVn2I8guOzQ0AMRhH1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=0uvMUYbc; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=0uvMUYbc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d63t80HQvz2xnk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Nov 2025 00:20:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xu5J2YUVmO+KaIFCwe3YTQ+9UN97u6v/RSU7wP6bNI8=; b=0uvMUYbckaKxc9ZGTp6DGbg3YN
	LALnRa7NcqVeGPt4nB5iXP1V4HqFy8LBFW7/xewuahRQ+6gPCw2f4WaEhI9ijAyzq6xNrwf7/E+M8
	UvW05os7ZPsFzkNKwfIlPDFicG82Pb+eeBdJi4Lf92Ogx+Yp8YwTCJ6bJaypmP2LJ6A0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJAl1-00DkSt-Dv; Wed, 12 Nov 2025 14:19:31 +0100
Date: Wed, 12 Nov 2025 14:19:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>

> > This is an optional property. If it does not exist, you have an old DT blob. It is
> > not an error. So you need to do different things depending on what the error
> > code is. If it does not exist, just return 0 and leave the hardware alone. If it is
> > some other error report it, and abort the probe.
> > 
> 
> Based on this for next version, I want to move the "aspeed,scu" from dtsi to dts.
> Change it to optional and accord it whether existed to decide it is old or new DT 
> blob.

I think that is the easy way out, not necessarily the correct way.

All systems have the aspeed,scu, so it should really be in the .dtsi
file.

What are you really trying to solve? That the DT blob says "rgmii",
but the bootloader has configured the MAC to add delays? You should be
able to test for that condition. If it is found, issue as warning, and
treat phy-mode as 'rgmii-id'. If the DT blob says 'rgmii-id' and the
MAC is configured to add the delays, the system is at least
consistent, no need for a warning, disable the MAC delays and pass
_RGMII_ID to the PHY. And if the blob says 'rgmii-id' and the MAC is
not adding delays, no need to touch the MAC delay, and pass _RGMII_ID
to the PHY.

Are there any mainline DT .dts files which say rgmii-txid, or
rgmii-rxid? They would be rather odd, but occasionally you see them.
Assuming there are not lots of them, i would probably just leave
everything as is.

	Andrew

