Return-Path: <linux-aspeed+bounces-3551-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C56FD8FC2
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Feb 2026 15:06:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMFCs5GCGz2yFc;
	Fri, 27 Feb 2026 02:06:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772118393;
	cv=none; b=fnYW2M8Wz2cygtFGrIoUHAXmMXfXn18B67vLVswBH/loA6zi3y2qxfVrJPPXumO8jA0tQYj7nOoiHINUh+BOG7W6FHNXX+2kfvujNUebNrc+b47P1SpobQe19Cib1V1Er0GOOlvr7p39rdCwwThe4RaNN+3NFxoMgbWKzQUKNQIQtjPVqX+7AQ1X5hisi7c6tbjtfoh/5ewezbIA+zZMIhKx1nSJiQDiSatyLYcaZFr3gkyovyKgm5qJgiJRTYTgmLtux9pSeeeQlSyfCUbvhGJPWs86Kbthv1o2mPR1uCVC/5poo1sVn+HakjrdajvvFe5wLMG4F2DdPe6i6eFEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772118393; c=relaxed/relaxed;
	bh=sppcnqILA2tjvw6TKSRMqAQpcumxQwdnuBhqn1AdTqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1m0nDAuEzSqZd3rCyHnsK8wtDqQkroWbLqc+k4HEauYE2kDOWdq37f6x+9GmsNRgwRgzv2BS/O+Ihj35RgOI7nwIWQHj1myQAzoNYDAWrZRHj5vD2J2ooMkzqcoEc+Vp593uLg7drAwPLSXDbwtQnakqZEJuTsDpMo3dw0J0migD0jfIWfPVssyfeY19QggP2Y7WQSLBnAnhLPCaOr9Uv+Oy10QklBl8vhLRd9flYswUNHzbpvwQosD1sDLzxEotDHWboQ7wvaH2YWX/sq+BrLOr5/PUWEST6x/134G7U324ydxkgpnOjmnyCpoXvlYiEbM/mTYJVnTlrbw1SAdSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mBBMvm05; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mBBMvm05;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMFCq3PCtz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Feb 2026 02:06:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sppcnqILA2tjvw6TKSRMqAQpcumxQwdnuBhqn1AdTqk=; b=mBBMvm05wtdNdy58rWBB4+xVTp
	ZvoqQB3Hi3d4Bx2ndMvT3t/UfsnipUVE6GN//goqK3BM+evLJaox/FIoxeIyk/NKtUt+F7sEjPH78
	1R9vHqc8kMAyWgZvrBhSwic3F6kIqW7neOJNy7XOSsaRyMpDdE35XOc+zcn7pcEYRArg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvcwN-008tqe-2N; Thu, 26 Feb 2026 16:06:11 +0100
Date: Thu, 26 Feb 2026 16:06:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "P.K. Lee" <pkleequanta@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Jason-Hsu@quantatw.com, p.k.lee@quantatw.com
Subject: Re: [PATCH v12 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <258747f4-9da5-44da-8eb9-24f8a8cbff3a@lunn.ch>
References: <20260226055521.1655243-1-pkleequanta@gmail.com>
 <20260226055521.1655243-3-pkleequanta@gmail.com>
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
In-Reply-To: <20260226055521.1655243-3-pkleequanta@gmail.com>

> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	fixed-link {
> +		speed = <100>;
> +		full-duplex;
> +	};

What is on the other end of this fixed link?

> +};
> +
> +&mdio0 {
> +	status = "okay";
> +};

If there are no devices on the bus, why enable it?

   Andrew

