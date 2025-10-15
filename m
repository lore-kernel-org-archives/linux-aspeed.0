Return-Path: <linux-aspeed+bounces-2454-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7202CCD184
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 00:13:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmWky20Xjz3cBW;
	Wed, 15 Oct 2025 11:13:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760487194;
	cv=none; b=HlV4qLwKaQeaG1X9JZ8Q2jOos5kG9K3pJaz45WXZR2r1ZWIthe8sgtnufh7pFoyWSmaPEXgqJhhYJYPHbG/dSGgOYvSAlMZiziK5iUNy5iqV2C1h5be8CVqPxUZnZK+EfcACZZHmsKHNt9a1AKOOpMtSm/lMGTOm0XJ9euk5O5AYdGD4psdT+Zanl5PLi3lI1K2Ey5/nNeREwRYHDvIBJiuSxRyLU41wuEeBjRGg5TO1y6Tpf/QEOipLfBZ811SSd8qnbqsK34MnVx4HiXfvIp67k7nQasKp/acHUx6TymAcXVt9ZyrEj6HZg+IQ9jkdzsrPTDf7wN93FbyxRqm+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760487194; c=relaxed/relaxed;
	bh=2a11Ly75LEhJitU7lNgDTcJn7h18/2bw5D0PDGOg2uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjgMb3DK5ael4frOurGHcQb5KC4fT9fHTVFw7edpNdeclrzG5pMHKzmO9Mbvmok47Rh/j4yKi/Iq/w0xMJTb3uR7UKyLtolcq914HTRZr4V4wAgh7HQEsdlE2ihepmJbMnqIP/VqueD0ZPfl8z0EcBuPaUiLG1QL2F65UaHu95UiOA1VcNk/cSgCQOccUEE4IoLaZ1tuNn7+wBrcuvtMZXWb3AblCoGYe8End6c7oN6HWfyOWwj7wROoms2qu1DmcSsSnwr+5IO09dIJwLCgMHd9xhCqIjgST0rWOYF3JoNYufm7AgKNfSt9ERbpzDR6Qe6aj1qFRvm6qqEeMMPYqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=MU2FHFDB; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=MU2FHFDB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmWkx492Wz3bwk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 11:13:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2a11Ly75LEhJitU7lNgDTcJn7h18/2bw5D0PDGOg2uQ=; b=MU2FHFDBYBDD2Cwr2NgqvMr4FQ
	c97EMfO7/hKIxqVgd5c9mkR+mPAKvHv+FXXOd0/DcyhkYuHV7WnpPzpBCocQ4CMYHVX2Xaoc0T3NT
	ClOWqa/a0Ht0CtD5G5dKPi0tRsVA0PIMu/QljKdRLn7h7AH1MTzMGSqTYWOCUEuAxlT8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8p8J-00Axwr-It; Wed, 15 Oct 2025 02:12:47 +0200
Date: Wed, 15 Oct 2025 02:12:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <2cf3132e-d255-48ca-b49a-f7b6303efe50@lunn.ch>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
 <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
 <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>
 <33b9d6d4-bb2f-47e6-8d3d-94a2ca2b8474@lunn.ch>
 <aO7RJs8ceO3mwjn4@localhost.localdomain>
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
In-Reply-To: <aO7RJs8ceO3mwjn4@localhost.localdomain>

> The fuji-data64.dts was copied from fuji.dts mainly for larger
> persistent data partition (64MB), and the latest fuji.dts includes
> fuji-data64.dts (instead of vice versa) because we wish to deprecate
> fuji.dts in the long term.
> 
> So it is a regression for fuji, but fuji-data64.dts is a new node..
> 
> My original plan is to add mac3 back to fuji-data64.dts (which will fix
> fuji.dts) when the rgmii fix is ready in aspeed mac driver, but I can
> add it back now if we need to fix the fuji regression asap. Please
> suggest.

Yes, please fix the regression.

> BTW, the current mac3 settings work in real fuji hardware because rgmii
> delay is configured in u-boot.

Which is the second wrong in "two wrongs make a right". Neither
u-boot, nor the driver should be adding delays with
phy-mode = 'rgmii'. That means the PCB is adding the delays.

	Andrew

