Return-Path: <linux-aspeed+bounces-239-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372C3E77180
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 22:03:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y93J823Yxz30YL;
	Sat, 14 Dec 2024 09:03:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734127416;
	cv=none; b=VxaaGNDAhmMOfaWFLPZSpsEvS4/87Ub0CZmQGGsozRDVqB1t7kdDApaH+96XRqFf8Xu3PEdbJanzXL9WCLcEPjrXTVWzB83bByaIrxQDma3t7G3iGpz7xXjBMrx6CkI9nZPg+N+bX9adkclWzXUfrzVS840Trphzj+4AjErNM6UnWyZ3t7fqIYlKotmkYfDWpzlOgXub8uFZ9xUIpl8YKNVxpjFlSbNeDI4ZBOjl1DoLLDEGdxGpmUyuosWKQC3yoaKMVRGhx2KxJvDo793pOrJtyqwE9uv3v/RAVT67YlgM9GX4cYKJxZU7swU78vBfhIHFQhjow6zDY/MPjG/A5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734127416; c=relaxed/relaxed;
	bh=eAJ5fUjEEvUD9VbWS1/Qwk4AOyP6PIZbu8dIgzfahvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elqic4dY50vOKI/FCe8CPBuPOViGoXJgX1iIL3dkCF+C+k3D4PgGBWHw8XFFTm/Y9Hkg61IPaXNK04Vmg/MIQuf49cNZiCpNlwBHbWQmHtBItdMwTA8FbTANvnf/c+h1hlwjILbw9gU8z1DJPzLsLPGYzh9VV8xyGFKnXY8vXl4hBOmkSyMvGJuxrKXDcXRfkSy7Rw2Dcx1/FdLbR8iahAEqu5LDQP9zPw6AZTDoWxDD2N8cudaWQHo7xUYDhpbUvc83BOhHtN22XUVhIxL4W/xPhalihxtPefy1pGCKxDZvVa/xrJGdG0onBEch53c78xFylSEJs9Q107lZHfa4wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=o8LES4es; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=o8LES4es;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y93J52dkGz30XZ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 09:03:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eAJ5fUjEEvUD9VbWS1/Qwk4AOyP6PIZbu8dIgzfahvY=; b=o8LES4esZv5ix34Gc9JkGkRBTO
	8jI9+EB6WnLt/SWorb5xz0+RR+w4GtBHikIa1l2xzyFOy/+DqD3IiiUsDn18/JmaOuNc1UqxmkS4G
	+wtVybgpSzeROJwq1f272TjTknbbYXdq0TiI7LX+1XeEeYlsePbam5iUH4WdIwXgLHUc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tMDkd-000OJn-GH; Fri, 13 Dec 2024 23:03:11 +0100
Date: Fri, 13 Dec 2024 23:03:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	NINAD PALSULE <ninadpalsule@us.ibm.com>
Subject: Re: [PATCH v1 3/8] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <4a8788c1-8424-40f6-a9da-bf135acad29b@lunn.ch>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
 <20241213145037.3784931-4-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213145037.3784931-4-ninad@linux.ibm.com>

> +&mac0 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii-rxid";

Why is everybody getting RGMII wrong this week?

Do you have an extra long clock line on the PCB for the TX clock?

> +	phy-handle = <&ethphy0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};
> +
>  &mac2 {
>  	status = "okay";
> +
> +	phy-mode = "rgmii";

Do you have extra long clock lines on the PCB for both Rx and Tx
clock?

I suspect you don't and the RGMII delays are messed up somehow.

	Andrew

