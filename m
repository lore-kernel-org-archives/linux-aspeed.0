Return-Path: <linux-aspeed+bounces-3853-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8C3FEEF32
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 12:42:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqm782YtPz2yZ3;
	Tue, 07 Apr 2026 22:42:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775565748;
	cv=none; b=ez4tKpFUHzMIiV+LiTlOwkNTGbosISDF40gTh8E03Zr/SSUUtllcJA/fwW6cGLGE+XQWNt6AgTImQ9ZS+aUjQV2PRAvWzbRWKEJzzJTKc/UTyA/4S2jrkHLPeN0R3Cv0SmUOGndRP3sTzA4UfD5SbRBWbmOmBuHgXKEyONx2vKvi4fhJTX1k0fV1xE4eBgddIQwXX50aloj1Tg7kwoELlsOAwA9qigWdLYxMWZQ4zyUVa7Y1Od5v8i5vZDwxPiOSz3q6F9H6AISIDnQFj2TePjJ48Q1oHiqHYHrX44ldJwHxdumnE8a6eOTpYgASBFjTCkAAVq35TDr0Rg6GCQVNng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775565748; c=relaxed/relaxed;
	bh=IUe9COmHpHLq20IfDV7wBf0fs3/+ozBHLuEm1gRfjmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET0VP3MaqL9dK12K6e3KmEPXWdFfT3w5J7jAaRoESm/dp5EPU73eJKUWT7xBbwgr9M7zBK26CDp3ivtvtgJUdrz7WXOShVsLbq/ms2PGtwgBd5rbug5AFZoWUwg/C9ff6ou/grTsAVHsUhHuuqGGt3GoGL93lJ1QbgKlx+wN2SibnASafEdkcYtViBbwUYFRBZk2iOpD77sgGw5UFd23fO9ZTq433c9taOg6JPD5dIhSvv3J+R76VdxwDdIHM26NPSh7Atzeo53asVonz0rdWV7MM3IdUsNYRQyQjT+SGyeHTkkf2Jw4ARwOCikmEwVOt5sbKsv8FyfupVZTLkCh3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BZCSfvhG; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BZCSfvhG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqm760rHZz2ySk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 22:42:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IUe9COmHpHLq20IfDV7wBf0fs3/+ozBHLuEm1gRfjmQ=; b=BZCSfvhG87/QSajNbHNCC3NuB4
	/W7rNrQu3UatpnJolElrFKOZq4jMof0N2Rt1geik4YqdBd3IP/DQcBOg5A7gQw3AT8mK0wp9rlqDg
	FV4mFajmd/brcgrS4FcrpjbVvrHE2GjkAWpTwPX9TEZW5WqyXGbcuIcpzVv5Yl8IARAQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wA5ko-00F81f-Uo; Tue, 07 Apr 2026 14:42:02 +0200
Date: Tue, 7 Apr 2026 14:42:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: PK Lee <pkleequanta@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Jason-Hsu@quantatw.com, p.k.lee@quantatw.com
Subject: Re: [PATCH v12 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <435616b8-8d4c-4814-8f21-d667755473f1@lunn.ch>
References: <20260226055521.1655243-1-pkleequanta@gmail.com>
 <20260226055521.1655243-3-pkleequanta@gmail.com>
 <258747f4-9da5-44da-8eb9-24f8a8cbff3a@lunn.ch>
 <CAK8yEODCyYxkggU+7=xzWFcXP6RMTpNbHyYRHZhahX7=b6reqA@mail.gmail.com>
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
In-Reply-To: <CAK8yEODCyYxkggU+7=xzWFcXP6RMTpNbHyYRHZhahX7=b6reqA@mail.gmail.com>

On Tue, Apr 07, 2026 at 05:05:12PM +0800, PK Lee wrote:
> > > +&mac3 {
> > > +     status = "okay";
> > > +     phy-mode = "rmii";
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_rmii4_default>;
> > > +     fixed-link {
> > > +             speed = <100>;
> > > +             full-duplex;
> > > +     };
> >
> > What is on the other end of this fixed link?
> 
> The other end of this fixed link is the CPU port of a Marvell 88E6393X
> switch. We are using this switch in unmanaged mode rather than using
> the DSA subsystem. Therefore, we use a fixed-link to force the mac3 to
> 100Mbps full-duplex RMII to match the CPU port configuration.

You are mixing up terms. The 88E6393X does not have a dedicated port
for connecting to the host CPU. Any port can be connected to the host,
using DSA tags. And all the ports are 1G or faster, so it seems odd to
limit it to 100Mbps. There is something consider a CPU port, but that
connects the internal Z80 CPU to the switch fabric.

> > > +};
> > > +
> > > +&mdio0 {
> > > +     status = "okay";
> > > +};
> >
> > If there are no devices on the bus, why enable it?
> 
> We intentionally enable it so user-space tools can access the switch
> registers. I have added a comment in v13 to clarify this.

Why would user space want to access the switch registers for an
unmanaged switch? It sounds like you are using Marvells SDK in
userspace to manage the switch, rather than using DSA.

	Andrew

