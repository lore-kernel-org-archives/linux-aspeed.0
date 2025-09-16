Return-Path: <linux-aspeed+bounces-2232-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924A6CAC597
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Sep 2025 00:37:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQjfC6Mhdz2yrF;
	Tue, 16 Sep 2025 10:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757983043;
	cv=none; b=NdM8hb3RbXVY29GDg4oMwmwVfoZuargQi0EKEGTGUwu0fxfLVvfvxItsiJxN+TAB/9d422R7jqLgo3srnL0XTvBQ3zyfDO3V12LKZaFQQV1JMiQMjV7KvruXYDYYTCSAZxUAEaVmu/wce7J1/cGbtX/2bcWeqd3ZyNyVCSyjo5ruaJn8zhgYaEfNFyDntRGIgD/1bMfNkcE6zrC2yf3MuG5c/8EHLBST3yY53DPoSSugF+JJcZFjPMwnMVo1EAsRHYBhx+TaClAeL2rOQKwzOLPYsC1S7qxLfLTtb5HVRyPl985CKWUbJIfuoRGwiVWeQ8fypN37MMKpI413YgLjww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757983043; c=relaxed/relaxed;
	bh=wJr+506HYavhLyAPNE14fMgJgbHbAikFhnzPhM0kVTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ixb/Jos4UWNEsw1XI92WJE3iR82i9fEPsT++J5JnWNsKmCnibcDh+wBQxRJRgpvLSbpt/lGsGaGLLAGoBaamOL0VJSiEFv8KLY9cnHXnSI0XnJItdaQ92ZKtHxmKDcWbzUWGrteLRQTulEq2QCN6wIxWXIJJLXb2HTp+/vr27U/M74X2Vnju7YLlfOD9xf77wFM3rhieNIeTl796POsTtRmiUAx2147f9RPq3sETKO+shuNaVTrut65eDLztmJTGGYZxZLrogI2KWMk7nJdQ90RZ1hzX4DPfhy3UYUWOdmoVNs2qWaXZzjevEserpQIdOrghNgaHb89ewmq55bVToQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=E2LjKSHH; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=E2LjKSHH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQjfC0XTtz2xnk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Sep 2025 10:37:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wJr+506HYavhLyAPNE14fMgJgbHbAikFhnzPhM0kVTM=; b=E2LjKSHHRSkxB/9Njm9q50MF83
	5VIRQcjknoMGoSETEPmq1ef9Bm/AV5jPSVpEYvzAaLcUJXhg10I9yN6duT7TuNjN+S7adLuZLbRLy
	tEvYLVQ0qxx+nfDYqjXvQHhOjUC17HFMHdR6O5up+6uOgNsk857c0y41t4QQwibbvQQA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyJgs-008V93-Hj; Tue, 16 Sep 2025 02:37:02 +0200
Date: Tue, 16 Sep 2025 02:37:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <74e68c53-2696-4f86-97d3-c0b0a74d4669@lunn.ch>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
 <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
 <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>
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
In-Reply-To: <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>

On Mon, Sep 15, 2025 at 06:26:04PM -0600, Rebecca Cran wrote:
> On 9/11/25 08:09, Andrew Lunn wrote:
> > There is no phy-handle here, and no mdio node in this file. What is
> > the MAC connected to? Does it connect to the hosts Ethernet interface?
> 
> Yes, it's connected to one of the host's 10Gb Ethernet interfaces.

O.K. Maybe add a comment please.

> > RGMII pinctrl is referenced here. This opens up the question about
> > RGMII delays. What is this MAC connected to?
> 
> It's the AST2500 MAC2, connected to the management LAN ethernet port.

And does it have a PHY? On an MDIO bus? Unless i'm mistaken, you don't
describe the PHY, a phy-handle pointing to the PHY, and don't have
phy-mode = 'rgmii-id'.

	Andrew

