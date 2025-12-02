Return-Path: <linux-aspeed+bounces-3031-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CC8D116F6
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Dec 2025 13:36:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLMJ75LTXz3bhY;
	Wed, 03 Dec 2025 00:36:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764682615;
	cv=none; b=n65LkehXsfQKLWql76qjP2kOs9RaqmSej/ZZeV+zMA07O7cO3ZFZxU/VYjBcoTaRiZQkZsGG26A8lgJeOkwKg2ByektH6rzaie+zBUHnu4qp9bJeNRu+7N5SR9E5HWAN2CVH/JPx8XJvcEK7XXe33gSTYM9lxWEAvALMS0wqNc8rchL0qxeFQ5jWxYduSp9bOF4QQM9p0biQDXWQpxTHdC84BrDyKcprEYe/h6n+EReTo4I7VLQtYtbrhcZv/le+jPuDALOHQMiElLdK0Sp7d7/73hTusGRIW9C74bFl0KUGNGI5B2OjXOUDJSZ4OXEmMjTNNB4HhOV635/9rAjOag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764682615; c=relaxed/relaxed;
	bh=1Wpx9IjkcuCXJrN+lvoQ0/PWGUe4eWqI7yjH11ZhMTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1fZkQ0iWQgH6pRokz2QQpU8h7WvdIHI1iGq/jeas/4oPaZ+DSzUXUqKqU7oqJosDPYetUcorHat6ZpOkJFxXwx4yJE5v3ADtjcg912jtOx7S5XxYFDLbcjtKH79EHK/GyfFey3tPpFSu7zogbTFGUe/S8j6hR+r9fFERCt+yOqlTV6srMy+B6BYVqxHTB83BEMe+e9uzIya0McWmJE9fXvxkUM8RLN84aKQDiGvbQoNzfkuJGyvgPzvriHTbOybta7zJ/PohgFgRgDkvCbmZIxZMhhqRkHS3GGHOQWw4TIqab8/jmsp7dKMioo4mdmOxRQlQevZaBDk2hyPz5RyXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=VC9d/UAn; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=VC9d/UAn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLMJ61SJ8z3bhH
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Dec 2025 00:36:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Wpx9IjkcuCXJrN+lvoQ0/PWGUe4eWqI7yjH11ZhMTc=; b=VC9d/UAnse+naHpZdifFVmTv3e
	21BAnHhjw8HPGF19RKmyVaDfCX6uHMOxsibeLkKxh5KZZeEQwS0ZaR2Ua03HSCUyahL8vElefUN41
	iBZxxnp/a8B+iPeb1ShSxBRSNEViUIygvNlf3anjA6FMYUa0PzxmLXuwq5Uhc3Ct54bE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQQY7-00FhXN-UW; Tue, 02 Dec 2025 14:36:11 +0100
Date: Tue, 2 Dec 2025 14:36:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Tao Ren <rentao.bupt@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <4f0e4aa0-166d-4a7f-b91e-42dbc6b832e5@lunn.ch>
References: <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch>
 <aSbA8i5S36GeryXc@fedora>
 <SEYPR06MB513424DDB2D32ADB9C30B5119DDFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <SEYPR06MB5134A5D1603F39E6025629A19DD8A@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134A5D1603F39E6025629A19DD8A@SEYPR06MB5134.apcprd06.prod.outlook.com>

> Hi Andrew,
> 
> I miss one condition is using fixed-link property.
> In ftgmac100, there are RGMII, NC-SI and fixed-link property.
> On RGMII, we have solution on dedicated PHY, but there is an issue on fixed-link
> property.
> 
> Example on dedicated PHY.
> The driver can pass the "rgmii-id" to tell PHY driver to enable the internal delay on
> PHY side. Therefore, we can force to disable RGMII delay on MAC side.
> But there is not any driver when using fixed-link property, which means
> no body can tell the outside device, like switch or MAC-to-MAC, to enable the internal
> delay on them. Also mean the phy-mode in fixed-link case is not used.
> 
> Therefore, could we ignore the RGMII delay on MAC side when the ftgmac100 driver gets
> the fixed-link property? Just keep the original delay value?

MAC to MAC is one of the edge cases where phy-mode is not great. What
is generally accepted it to use rx-internal-delay-ps and
tx-internal-delay-ps with 2ns and a comment explaining it is a MAC to
MAC link, with this MAC adding the delays.

I suggest you see how messy it is to implement this for 2600. If the
code looks horrible, keep the bootloader delays. For 2700 you have a
clean slate, you can implement all this correctly from the start.

	Andrew

