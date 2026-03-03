Return-Path: <linux-aspeed+bounces-3583-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871C7EB364A
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Mar 2026 01:31:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPytk4phmz2xpk;
	Tue, 03 Mar 2026 12:31:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772501470;
	cv=none; b=a1+2nftMNoVRgT+oZnCSdHHEFjvyejOFrIMf3Ca9Fb4toPuJ2S6KT4LR2+TA7FogoEussmcPoDSQwyPfM4V5ESVZ97fZmeWg9t2gS4+3+bUYYK+ydzFqTiiz3d9wnakbX8ZUBteSfoUqtHV7FFG323gwugnmg6ccPI/bYuYe8tYgUelny/BiVDoQTaZ+vptzKmiZEyRZZ27nL7iNA7FROYl5v3BsPPaYvS1w0eonxG4fBxom6Ex1AdbNqEDUH+wQBUpGDTLf+NlBRtKra2TMuuL+Lmb5oG5lAB3ZNk50yrc8fXxSnmSUBEMToEFi/pfT25/VCTuyMiHm+h41XlKJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772501470; c=relaxed/relaxed;
	bh=HUKL9Y5s8qQvy223sWGjb++3da04HXQ26Z6GEuwMerc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6x0g9jFKC4wv8ergnDhrdMHYERgb1y00ipBtiIIO0q4dSnZf/AhXx5IowBtq4+U2hWSm0kcbiFJNlMzt05lryY4FyKaxWF2df98K5VZlTHY8cGZqXswjUQ76eMIwM/Sqj9FhXxyjEksQZlF73QaQKZKhJGCqVNJfhgEQhZzIh5ICm2AhFM2RCd9EKOleQMZwguSjx21M4LIvpq+0e+hayKrW6Z0VQgJdjUTRL+n21AeIskBjGDQ3MgB/FQaniZg7t00NgwUBHj+KVhV8wHzjiOqVktYHu3ApxFMNNhwTPSC48uuUiaB9mLCviB2D9u6tc1RZuHv2dZ9E/70VjNw0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=TF5B/smj; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=TF5B/smj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPytj2D49z2xRq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Mar 2026 12:31:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HUKL9Y5s8qQvy223sWGjb++3da04HXQ26Z6GEuwMerc=; b=TF5B/smjiLlQUtcGCfFsFPta+Q
	1ont1wMORchdXMOo5dHeQKh92q1h4bXTT8IichY2T2BiPzhYhKw9xqEvdkPCBG6A50bik8lgs2ZTZ
	b0F8FKG1cnbzD68qMusKDyL+TXyi/JRRIkyxbRJ/c5cUfoXXONa7rrnAkTQctM7hqLR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxEar-009mO2-I2; Tue, 03 Mar 2026 02:30:37 +0100
Date: Tue, 3 Mar 2026 02:30:37 +0100
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
Subject: Re: [PATCH net-next v6 0/5] Add AST2600 RGMII delay into ftgmac100
Message-ID: <ef88bb50-9f2c-458d-a7e5-dc5ecb9c777a@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
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
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>

On Mon, Mar 02, 2026 at 06:24:27PM +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the
> Aspeed AST2600 FTGMAC100 Ethernet MACs.

I've been thinking about this some more. And i would like to propose a
completely different solution.

What we are trying to achieve is allowing the correct phy-mode to be
used in DT, rgmii-id. Being able to specify internal delays is nice to
have, but for most platforms should not be needed. It is only needed
for badly designed boards where the designer of the PCB did not take
care with the length of the traces.

Part of the problem is that the MAC driver is not actually
"broken". It does what we recommend, read the phy-mode value from DT,
and pass it to the PHY. The real issue is that the bootloader enabled
delays in the MAC, behind the MAC drivers back. Because the MAC driver
is not "broken", it is hard to "fix" the issue in the MAC driver.

So lets solve this in the bootloader. I suggest you patch the
bootloader to no longer enable the delays in the MAC. It also needs to
patch the DT blob. If the blob says "rgmii", change it to
"rgmii-id". u-boot should be able to do this.

That should give backwards compatibility:

* Existing DT blobs with old bootloader gain the delays in the MAC.

* Existing DT blobs with the new bootloader gain delays in the PHY.

* For new boards being added to Linux, we NACK them with "rgmii", tell
  the developer to upgrade the bootloader, and use the correct
  rgmii-id. This is a power we do have.

* Developers of existing .dts files can submit patches to replace
  "rgmii" with "rgmii-id" once they are happy all platforms have had
  their bootloader upgraded. That might be never, since developers are
  lazy, and we cannot force this on them.

	Andrew

