Return-Path: <linux-aspeed+bounces-3066-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6A8D3B994
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Dec 2025 20:51:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dQrby1bNDz2yF1;
	Wed, 10 Dec 2025 07:51:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765313470;
	cv=none; b=eNseu99q2eK0wUZs4nepmAZXfoeBFHMW466E8+Q4BpLrSjivobKOz+T0nCz5WcWKrp8C2bAu5L/Wg330CYj3SbVe+yruCkWmFgtYrPFvNBpAF28+4+9v/BDO/CPwTuUE0epTJvwYxuwdOgI/aYrEN2ft3MgJySeNOd/xtAxYS+UsdEGsmUDRONZ/b0ihFxpfz5wlaliVp0It9cwhHG6ndvPATt27DJrvjAQkytEavD7n3qjOg5Q61c3nu1ln+atqIHlfwOwgeOW5AkGgjcaPcdL1B4fRd1q5+ODfEHy32ujY9L7ZcPfR2cnBRJyIz4o/kM70FSItMPh8OjUYJYu85w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765313470; c=relaxed/relaxed;
	bh=r1Q2uDduf66UtYmH0gKmUDjODIcqlhFNLGyTzwxqXLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdrjqwtOdkjm2kPpv1qGU+471exMCEur3aW4kwqzfcPkAjtgkTONfXMEfFD0/c2sOecUmQiK26rXV4UNuUjYxtXg6WJQ7JMuyW3LI9I47CWw7vEowhpXbXSBzQaPZUTuWP9vYPkfOyxFzEAEGLV+Wm042oRdYATchqHi0ADyv+RjpW/PJ23FO96xw1HspS1YeDe7j2xvHoyAbfsj3ircx4fuv/aNwHQYkLQFtcg0JKdR2nWUT86gVsU7m0L2dRv8cWv3BZAoi5S98WsWCySS855NJrnRQpZC524uf+VHfhe71vuD5+DPl4HCjeI0ReIo55OI3vn+FVQV/ZALqP/7WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k2FHVx10; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k2FHVx10;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dQrbx3cHSz2xs1
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Dec 2025 07:51:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3973D60051;
	Tue,  9 Dec 2025 20:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA14C4CEF5;
	Tue,  9 Dec 2025 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765313436;
	bh=+NrxrvZMgkcpBUKcfznjEv3pgGvqP8bd/L6BGqUssYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2FHVx10lU9ymJ024KMK22dlyRk155qhGloao/pSRz4jhhFpXovieBQvErMqIjWb0
	 AdZYlCm48RH3jrzdGsS/A55Wdu3GDDkl+qUTLvPs0cg1bd27lhDg6VjF4eyQtc9Pv7
	 ucRGmTR5z070mWSQ0GBmGg/MF17WszEWWkJA8b7e+bvOBrI8mFv8yg92qsOdtvQv0M
	 fsUjo5De94mBVOfFI1b3L7nVyZbOFGz60p5XuV1v/cjaI8zRQnF7Z6a4UX1Q8q98YJ
	 RO6IGfa/XlMnaLYkxPSQ1XFordW8jMm90tsWcYYLbYfoot2Y8PoiZ3n0nYeQ3yOJ0Z
	 buLKTnh/ZOkGA==
Date: Tue, 9 Dec 2025 14:50:34 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <20251209205034.GB1056291-robh@kernel.org>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
 <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>
 <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>
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
In-Reply-To: <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>

On Sat, Dec 06, 2025 at 07:30:30PM +0100, Andrew Lunn wrote:
> > @@ -1907,6 +2179,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
> >  		priv->rxdes0_edorr_mask = BIT(30);
> >  		priv->txdes0_edotr_mask = BIT(30);
> >  		priv->is_aspeed = true;
> > +		/* Configure RGMII delay if there are the corresponding compatibles */
> > +		err = ftgmac100_set_internal_delay(priv, &phy_intf);
> > +		if (err)
> > +			goto err_phy_connect;
> 
> Thinking forward to when you add 2700 support, i really think you need
> to break the probe up into helpers for 2500 and before, 2600 and in
> the future 2700. You currently have a couple of tests on the
> compatible which you can reduce to one.
> 
> In fact, this driver has 10 calls to of_device_is_compatible(). I
> think you should first refactor the code to list each compatible in
> ftgmac100_of_match[], and add a data structure which contains an enum
> of the MAC type. You can then transfer this to priv, and replace all
> the of_device_is_compatible() tests to just look at the enum value.

Better yet, define a structure which defines the different settings 
directly. Such as:

priv->rxdes0_edorr_mask
priv->txdes0_edotr_mask
priv->is_aspeed

And anything else needed...

Rob

