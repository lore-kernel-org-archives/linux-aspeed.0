Return-Path: <linux-aspeed+bounces-2440-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825BDCCD184
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 15:11:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmHkF647Sz30M0;
	Wed, 15 Oct 2025 02:11:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760454709;
	cv=none; b=BeUouV9/23iOe+p3FJ0V6cMmtkt2PvN4G80MfXDMIL5q1br7euOXu8b0MwFln4MtntasU52IOcZai51+IVBt3N0CIqy8bxj9Z1PVNhKqrwHHUD2BdIYMMnF7O2MIfauPjkptvd2y/5oRyfKTxSyNhJvWRS7Ys08sK5+xnjiiCoQsAXLR0QSjTT8ORAtHiqSegD2dD6b/QhKtVZlyT1xLNn2OW8N1VcQK6PV2p3p/B1UNlWu1t/f38iAf0NKxZWVIKF9DmW0jjGh38NsN+5IKFKhucIWWMoMeSkxxrduVtiT5nWSbhoylowEu7aek38COFLTpIq4qicy1IckU9Wedbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760454709; c=relaxed/relaxed;
	bh=37Nmg2NVeBxxzfJbfuXsD1Mwnh3yE228KQ/4hDiITzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnGN3fMXsE3BxBW8FL5DQ03U6w+sVxry0IA4diTRrMm0F0DD5aPmQfEWLtdUBJ8hQzbWmHo5kZzVHeHh5VqszT7m7aj8iAsStSzrGfoau6zftAKcFu/bWSB3Rg3u32U6R/GD/oDEY3LKPH72sBqV6h6E9JSWFQlCO57oOKd3DUDz6q6Kio+Tcf6kYEy+uhf9nJM6Os4z2NWs9qbUCjKxtiEWdxYePFyhtUkv7LCWGqUELeUBuKOB/ZKjBeuBwgW/+R62SIvXme+CIF8soaWd/X6UHiD3sP2x0zpAHv+pa9Sr/CUHq0yKaSD2kbnmymVk8MpJwjwzlxhLa8vEvG1zfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dPNOZ9MP; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dPNOZ9MP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmHkF018Mz2xPx
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 02:11:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=37Nmg2NVeBxxzfJbfuXsD1Mwnh3yE228KQ/4hDiITzo=; b=dPNOZ9MPtW2WVRmqQR3u2LpP6L
	uptROoyNGK69M2qy303wCSQ08YH58U2pV6nabHmV4yubRoZo3KZwD6KYU4wT/PC7p9jIp5x/zyLnv
	my7lTuyeVrrF2PsuULGhQHqYtNq+z+4Dw8VxhlwXeNUGZkU2qbO4Wukrq7DxsDDbN+P0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8ggM-00AvfK-Pb; Tue, 14 Oct 2025 17:11:22 +0200
Date: Tue, 14 Oct 2025 17:11:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tao Ren <rentao.bupt@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
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
In-Reply-To: <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>

> > If it is already in mainline, i don't care too much if it is wrong. We
> > don't want to cause regressions.
> > 
> > I only object when adding new nodes which are wrong. If we keep adding
> > broken nodes, there is no incentive to fix the broken driver to do the
> 
> This wasn't adding an allegedly (sorry, it worked for me) broken node,
> it was removing one that worked for me all along. Obviously I do not know
> if it worked (or if it is even used) on real hardware, but it worked for
> the fuji-bmc qemu emulation.

It probably does work on real hardware, because it is one of those
"two wrongs makes a right" cases. So i see this as a regression. The
node should not be removed. It should hopefully get corrected sometime
in the future when somebody actually fixes the aspeed driver, and
fixes both wrongs.

   Andrew

