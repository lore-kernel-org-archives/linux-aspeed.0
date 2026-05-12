Return-Path: <linux-aspeed+bounces-4016-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E776CD4F24
	for <linux-aspeed@archiver.kernel.org>; Tue, 12 May 2026 18:36:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFQJz4LDHz2xjQ;
	Wed, 13 May 2026 04:36:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778610963;
	cv=none; b=kn8xSndOqbQNnvekdTLGAFslmek2kYRdqzCUPs7gUct4KTLIyfcGXfJkVALVG+l9cB9susn8BHU2qVaZztY9klLOEoJML8T2YxvWlPn4otplzY7JRbFpHYfWnoTIFz89dodANKiHg6qTQdJ4azws1W0XXCB2xdhDN90qQ9T4IJPRB5+jhOKxYekKcBY/UP4m1ka28TWFUdk87pe5Ks44nlf+xLB9jBZbYf80htgCGYn/d893TRYw8G0bvH2i7ZJydiN4PGXzV8s/Md1lMr7G9SH6ZA9tBEcs/G3moPHeVwFuYzJMRwcaAM8sHE471hQz1P6llf0R7yumztQVFgsk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778610963; c=relaxed/relaxed;
	bh=+WDbnRCHLFMZ6i6H4Zt/0Gy4jkd8hmSy2ikld2vqGyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY//fzhs+25rbORPiiuvFYsaEtjSUl0XA2OxM/Bwok37v1KzyoMpbqSxzoS5u83eAGiGEr12OwQfNsRtuloS/eRc3cxIQlp61GDAGuuXuDP2xj1BLkbACC5p3C2kRrpv/3+azHJd8OEcNYug8to+4a7fBaNi7k7t7fadVdUETzA6A2ZLcRwRgSWrnqAcFib483vfnppPYgi6y4oLUr4otP98dlHvS1oOAj/Y4xxPVghRGTYjOz7i0hJFaADBeI8ByfmSOERXNpt7+ew/mNLBP70mARGsb5bh6jN1IU5tl/X2VC5kGsR9h16IOSturfDizVgW8NqvHBefmVyI26X4iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nV2d+QLp; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nV2d+QLp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFQJx5xsbz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 May 2026 04:36:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+WDbnRCHLFMZ6i6H4Zt/0Gy4jkd8hmSy2ikld2vqGyw=; b=nV2d+QLp3RrNtrhdA34wuJcAwM
	gs/9x/bxhYD/Wg/yRraDtqj4Q+4emUAjwDF9PmAkBgW0dy9W90F5SfnyYxnp8fSnPZUmOSszRwCt9
	LDbLbt8dm7uT/NAyVbD0hQ5zBA0aH/dWcwSyDM6kc8EMWb5JSx0ukeFDsQ/1YARecg64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMrxA-002bMi-Po; Tue, 12 May 2026 20:35:36 +0200
Date: Tue, 12 May 2026 20:35:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Message-ID: <5427ff70-4676-412d-8294-da5743c736a7@lunn.ch>
References: <20260512175019.47548-1-prasanth.padarthi10@gmail.com>
 <20260512175019.47548-3-prasanth.padarthi10@gmail.com>
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
In-Reply-To: <20260512175019.47548-3-prasanth.padarthi10@gmail.com>

> +/* Dedicated Management LAN */
> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;

What does this connect to? A PHY? NCSI?

     Andrew

