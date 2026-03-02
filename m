Return-Path: <linux-aspeed+bounces-3576-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10226EB362A
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 18:01:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPmw747NMz3bn7;
	Tue, 03 Mar 2026 05:01:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772474503;
	cv=none; b=R8unjQ0zgFym8kHlJ9Z45k5mSmWkM4469Hg+I9ECctZeBEQf5RgbtayRxqnch9HhbrQ4w8Y8HoRjJYDpN3wYqbumLfEVbOC1COhYc+5H2gW9F0D/RiSWTmkDkhXKdIlksEtmnJvkBjrSUQLCRwR5L+sWFhIHfUVpypXrxG9wG9yZOHsWfe43YdBBTJyElg2o+EggWj4i6OoYRc8jNhncR9v2EwdBfLfwRWsT1kT5C18RKXvTMKkGNaa78nM6ehwuuNKgwyUf0ZZi/JLJ8VvQklo7uoU3kKZpzWl1XKLcKyyRW0e3JxyOR0/lg2c9db8Yy49Brti63OnKLk0JeEJrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772474503; c=relaxed/relaxed;
	bh=3XVxUv9VFGIs66kBS1ywELCiYjFlBgmw/wMttbaL4lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lll8M41YbX3vc4HvpF/4mg9KhU1KoO/HKR5sr1bYkTtBE+gUaPpLpcE4101LDK7r1eU6zd5ueM+f9DXV9/LFS0A8PcLpsNzp2cswFyiMyG8YecbpMrOOm6v0FocNGjYvtqIrEElmUnq2wVPhO3fG8aoOP9hhZLG+k9JTJeriqKeA1B6CiC6DW0MY5FYosCbAV24iIDSu9NVC98b1FG8kAKoqunjoVuWHERszbFTmuN9D2uO6Xk+Zqk3tNJ7pgFx1Kc8CuQqPK/pjHz/DvgRx6UXwcnx8VIski4cg2VU+8ugjsdgspgBoMd3XpKWqZBPS1OxKFtrCE7cORzRI8+3wpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gGtDOT+Q; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gGtDOT+Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPmw60BXCz3bn4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Mar 2026 05:01:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3XVxUv9VFGIs66kBS1ywELCiYjFlBgmw/wMttbaL4lM=; b=gGtDOT+Qt9xtniDHEqZTXpL5qE
	q02Tcwgb3cHkjMblOBuBCbnaCjoXE4LWITTF6Pbgt3mOd0CUE3tpHk1aIKfaXPJWMi0G7ieaQPr6E
	iNMRM8hf+ka/Mvo37+L2xxLWHCKicGbduW6+B4dkJBjyyCfSre6dmbfp0B1MdAmooAxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx7a3-009iZ2-HU; Mon, 02 Mar 2026 19:01:19 +0100
Date: Mon, 2 Mar 2026 19:01:19 +0100
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
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v6 4/5] net: ftgmac100: Support rgmii delay in
 old dts with AST2600
Message-ID: <4a3975a5-f002-4c32-b45f-0f04edbfd25f@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-4-68319a4c4110@aspeedtech.com>
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
In-Reply-To: <20260302-rgmii_delay_2600-v6-4-68319a4c4110@aspeedtech.com>

>  static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
> -					     u32 rgmii_tx_delay,
> -					     u32 rgmii_rx_delay,
> -					     phy_interface_t phy_intf)
> +					     s32 rgmii_tx_delay,
> +					     s32 rgmii_rx_delay,

You introduced these parameters in the previous patch. Please get the
types correct from the start.

	Andrew

