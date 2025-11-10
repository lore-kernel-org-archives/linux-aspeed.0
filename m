Return-Path: <linux-aspeed+bounces-2858-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77BECCFA13
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 15:22:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4th10gTGz2xqh;
	Tue, 11 Nov 2025 02:22:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762788145;
	cv=none; b=QRCJvIM9F7+20UY5S6S6efJ0I9bzZGvQSIhhiBd9bLSqjOLQkXX/WtNVlaxaMF7aogK+dG6TDqdI3rXqr/jbLuBCQ7yneACCBcgKmTwsyFKKcUZ0+BU2MxI5zmdGF2BhTG/HpAbG8p0KxKBLuoxob+5KWYtnl/3/G3mhCvRPqiLae6xb6gR520P6heq1cpHSxrl0A88CYBOukbYUAUCNZFv88qITvLQwrSElmk/aPQrxoa5I5ZiEbmph3bVY/ieSKTF0mr/hTCRN5tK23PIezrz1SjWPYsaZbV3tsWsCGCmbLGmlAuN+ANfwjV+/W+Fd3EyDsGz3HjDupNbivsU4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762788145; c=relaxed/relaxed;
	bh=Awr+81kQsRnEBxn06SpEGdo1D44sv/W67zP5wVfdji8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF8gvFMS4g8aavKtjXLJGDUg4NXGOWVpSTzcTT4mm5N/Gri2zoAY78CKBEw+bmZOZW+SzFSoSaQhdOUCE0znfVrmMDtNOehaN0ObKJAbNT+heqWUt8LY7FnNVU77RWOoHbCvPf+rUv7CdTHnOKbbS6WrBXkpMIGu4OwGPZP1FZ3bsGT5tUTaCbMp0y29LMiDAh+uuRxK/kjK2kScmfOl1/AmHc7G6tvyCY2SZH93TThdYHJ5DP+49xFIlAQ1mpoMAjcGpFimIIQbeVPMJ3JYiMydJkn9htHxoGCXOrRRoXMwWmJHS2/7zcfYIuZqsSI5a5sis8VQLBawQO0fyCGuBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ztiH7bgv; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ztiH7bgv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4tgx6mmJz2xqZ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Nov 2025 02:22:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Awr+81kQsRnEBxn06SpEGdo1D44sv/W67zP5wVfdji8=; b=ztiH7bgviNzNanjroR1I3K9ala
	g4VP79+oXXvnv4jp8O3mC+I7CpuE7e3ZyKbul3ax9mvMQ6uF7ZgjsEZNlsmW9dsatq3/x3Y8DcaYg
	mJNFvp8XO6OaYEG83DMlc/K8uhCnXFrzIYQ4gaGxb/KYyaWvHCnkNFd/0FERfx4c+qj4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vITi7-00DX2g-4E; Mon, 10 Nov 2025 16:21:39 +0100
Date: Mon, 10 Nov 2025 16:21:39 +0100
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
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <aeb5d294-d8c7-4dbb-a159-863963d38059@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>
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
In-Reply-To: <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>

> Add the new property, "aspeed,rgmii-delay-ps", to specify per step of
> RGMII delay in different MACs. And for Aspeed platform, the total steps
> of RGMII delay configuraion is 32 steps, so the total delay is
> "apseed,rgmii-delay-ps' * 32.

You already have hard coded base addresses to identify the MAC
instances. So i don't see the need for this in DT. Just extend the
switch statement with the delay step.

    Andrew

---
pw-bot: cr

