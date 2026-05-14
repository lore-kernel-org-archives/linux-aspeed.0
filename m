Return-Path: <linux-aspeed+bounces-4027-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E6CCD4851
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 May 2026 12:08:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGTd70499z2xy8;
	Thu, 14 May 2026 22:08:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778760522;
	cv=none; b=OyOaMAGsE0Nmu7MS/3sN3hb8nJc2BFHRHDkb9y5+5Z3LRzbRHpChBFijFFrXHAUUC/PVnhXvMpl9WZiRAh15TfGvwO2ffXBQihoLyQ1v4t8MKLsh7F28K8OUGVAcYZJ5g+wL5k8B05ipZZwdwSJ0fGrrblOYosfzyQJvzbVnmhTYxkPRddO22pbet7nl618ZX9TCVtMU8mEROcb494YLgrKVeGPiVB09g05m9nP5LBxz7qFWaKkVHN3fSaTFC5WwNWam71RCvEbwjiV80Xj9ttuGfGqO6TnlFfeWKa+Fc+o6Uy35PFv7SybuWbdjV6RissOTvDzyQql8ga9f7LsogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778760522; c=relaxed/relaxed;
	bh=Tso+x53GYlnnd0bvooYwZlfjSVUPwDAvBozCDW1Oo58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npi/Cc7poTmWaWs90k7HTNEHUqY9LjhWmwlPxdK8yMDHdWM9uaeNx2QME5JQWzvtNbPuq1YFIpBkIAs2UTzh7eAaz+ps8lH5L76vE4WcWHwyhDCQSq+WlFbU3Si3YV12Mk6EY1ofrNuAMLSFTJTWneSag9iv5GlvIuFMTu8+FEiJM3cq8ULUNa+aT7N8G5fjnRmKadY+hRleMlKbBZMmjR7njI+3465sHYxtiUaOwjqsMpo9lumr88A+2/GWKIJKTWnhOlDeZ+XtAkDFJzGUCRrzg6yKOH62UDH8fKAwjx02TsOgWN+VpmkjWs46aIO3gvPpaXDeIE/3xfBT8Hck2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=N42aHMGc; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=N42aHMGc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGTd44F7gz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 May 2026 22:08:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tso+x53GYlnnd0bvooYwZlfjSVUPwDAvBozCDW1Oo58=; b=N42aHMGcEd3zaZq6JElfHZEouQ
	+DhFxWFVsxTwX7NXiV2+zHnq+cZuoEX6ZfJFp65Cu0xLKfjhUo4LI1ng4MZI4y7FTjjY4L3W/X/gp
	cra0CT4Y+gYEHqsX7o8KzF0XKfJyS9O+oe2YCP15HK8e5bkuhSvuwCPIL6mttnemsstw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNUrS-002trT-CM; Thu, 14 May 2026 14:08:18 +0200
Date: Thu, 14 May 2026 14:08:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Message-ID: <a71d6b4c-fba2-4f02-9603-4370b52663e1@lunn.ch>
References: <20260514031622.1416922-1-prasanth.padarthi10@gmail.com>
 <20260514031622.1416922-3-prasanth.padarthi10@gmail.com>
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
In-Reply-To: <20260514031622.1416922-3-prasanth.padarthi10@gmail.com>

> +&mac0 {
> +	status = "okay";
> +	phy-mode = "rgmii-rxid";

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

Please could you explain the choice of rgmii-rxid.

       Andrew

