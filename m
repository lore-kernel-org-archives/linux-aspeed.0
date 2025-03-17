Return-Path: <linux-aspeed+bounces-1013-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9EFC282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 13:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGZzv5kVHz2yqL;
	Tue, 18 Mar 2025 00:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742216939;
	cv=none; b=PaM6WWdXc4CPG2ftcCNgi/VgYUvX5zsDxPjffzfm8FFDfe43sQA1OoeksFiHbSYNltQYD9/w4QwTsbxWH9SfQC6SdHlmpfS4coXQwzNLVnl5c4k4VR1hXvCJqr0LVMvGcAHf2z5LvTCBB3HB9IUu836AtZigH527/Q+DTwUmewe4Mvb3gbcpOj+je5kviKkyxfa3WCJfvyizG61CAOaabDiXFyzmFYODBp5K1pQgXSjoVYNRaqEI5ye1Q4Xa521OZwJMjhyxsYD/BiW11vLdYXZwG8zUarQqbLxf5uNAnUPK+bc29sH2W+36CVsSAaF6ahJPoPzumNevyYLBWNnupg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742216939; c=relaxed/relaxed;
	bh=5KAN/TL0PYijvGqP9Y/30zrHPi/CEWhklinOLwIY8Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8jvT1YfTdhsGS41TuYaK06eQCmO5tONwuSdXcvwZrLm4FwzQv007gcIIbBePFXmGSHy2N1Vn4nidMC4LX6xt0JccDRXXswOd3+Yt2l41QFyL9zuA9exUrfUxfXnvmPJi6Rnq4Vz1d8r/vIyEX42FjnLkvRNcAu9itmUt3Wgsl1yocelvRUNdLszNbRbwbfS0JI2bBvlMBH6oi0Hkdd7ARVqaS7cBIL/6mD03XvDKzMyoitk8l+jSNKs3fFgxZ/O+n3XWvaTtoMCIyEc/Xz5UzuumKBi4tUv/P6cOP/xml4PxjUeR2wqKQQwLP6UZ/DQQMxGKxa7ywhkNpo55XzVUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=A4E4xZ/X; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=A4E4xZ/X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGZzt68wjz2ydQ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 00:08:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5KAN/TL0PYijvGqP9Y/30zrHPi/CEWhklinOLwIY8Ws=; b=A4E4xZ/XcQNU1dNttR8vxdIB3a
	G8tZgnwP5mdeK9G06uuDMoRIhp0sey4w4eB9vB4WlX3MPdCdy/vlZixCQh6m6oNGI1tolR2Wdjp+z
	OHmy/9ZTzpRQjgO8XmJB534lYIUycJTgaiVuWdhuNM9qm+LJkvTqQmcdTYW22NszkbCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuACv-0068Qc-Mz; Mon, 17 Mar 2025 14:08:41 +0100
Date: Mon, 17 Mar 2025 14:08:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [net-next 2/4] ARM: dts: ast2600-evb: add default RGMII delay
Message-ID: <5db47dea-7d90-45a1-85a1-1f4f5edd3567@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-3-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250317025922.1526937-3-jacky_chou@aspeedtech.com>

> @@ -147,6 +153,9 @@ &mac2 {
>  	phy-mode = "rgmii";
>  	phy-handle = <&ethphy2>;
>  
> +	tx-internal-delay-ps = <8>;
> +	rx-internal-delay-ps = <4>;
> +

Ideally you want:

	phy-mode = "rgmii-id";
	tx-internal-delay-ps = <0>;
	rx-internal-delay-ps = <0>;

Since 'rgmii-id' correctly describes the hardware.

	Andrew

